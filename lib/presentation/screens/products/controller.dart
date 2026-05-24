import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/utils/product_sort_option.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/beans/product_filters.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';
import 'package:hedma/presentation/bottom_sheets/filter/filter_bottom_sheet.dart';
import 'package:hedma/presentation/bottom_sheets/sort/sort_bottom_sheet.dart';

class ProductsController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final FavoriteProductsService _favorites = Get.find<FavoriteProductsService>();

  final categories = <CategoryBean>[].obs;
  final products = <ProductBean>[].obs;
  final selectedCategoryId = 'all'.obs;
  final activeFilters = ProductFilters.initial.obs;
  final selectedSort = ProductSortOption.priceHighToLow.obs;
  final totalCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _applyRouteArguments();
    _loadScreen();
  }

  void _applyRouteArguments() {
    final args = Get.arguments;
    if (args is! Map) return;

    final categoryId = args['categoryId'];
    if (categoryId is String && categoryId.isNotEmpty) {
      selectedCategoryId.value = categoryId;
      activeFilters.value =
          activeFilters.value.copyWith(categoryId: categoryId);
    }

    final filters = args['filters'];
    if (filters is ProductFilters) {
      activeFilters.value = filters;
      selectedCategoryId.value = filters.categoryId;
    }
  }

  Future<void> _loadScreen() async {
    await _favorites.ensureLoaded();
    await requestCategories();
    await requestProducts();
  }

  Future<void> requestCategories() async {
    final response = await _productsUseCase.requestCategories();
    if (!isSuccess(response)) return;
    categories.assignAll(response.data ?? []);
    if (categories.isNotEmpty &&
        !categories.any((c) => c.id == selectedCategoryId.value)) {
      selectedCategoryId.value = categories.first.id;
    }
  }

  ProductsRequest _buildQuery() {
    final filters = activeFilters.value;
    return ProductsRequest(
      categoryId: selectedCategoryId.value,
      shopId: filters.shopId,
      sizeId: filters.sizeId,
      minPrice: filters.priceMin,
      maxPrice: filters.priceMax,
      sortBy: selectedSort.value,
    );
  }

  Future<void> requestProducts() async {
    isLoading.value = true;
    final response =
        await _productsUseCase.requestProducts(request: _buildQuery());
    isLoading.value = false;
    if (!isSuccess(response)) return;
    products.assignAll(response.data ?? []);
    totalCount.value = response.totalCount ?? products.length;
    _syncFavoriteIds(response.data ?? []);
  }

  void _syncFavoriteIds(List<ProductBean> list) {
    for (final product in list) {
      if (product.isFavorite) {
        _favorites.favoriteIds.add(product.id);
      }
    }
  }

  void selectCategory(CategoryBean category) {
    if (selectedCategoryId.value == category.id) return;
    selectedCategoryId.value = category.id;
    activeFilters.value =
        activeFilters.value.copyWith(categoryId: category.id);
    requestProducts();
  }

  Future<void> applyFilters(ProductFilters filters) async {
    activeFilters.value = filters;
    selectedCategoryId.value = filters.categoryId;
    await requestProducts();
  }

  Future<void> onSort() async {
    final option = await SortBottomSheet.show(
      selectedOption: selectedSort.value,
    );
    if (option == null || option == selectedSort.value) return;
    selectedSort.value = option;
    await requestProducts();
  }

  bool isFavorite(ProductBean product) => _favorites.isFavoriteProduct(product);

  Future<void> toggleFavorite(ProductBean product) =>
      _favorites.toggleFavorite(product);

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }

  void goBack() => Get.back();

  void onSearch() {
    Get.rawSnackbar(message: 'searchComingSoon'.tr);
  }

  Future<void> onFilters() async {
    final result = await FilterBottomSheet.show(
      initial: activeFilters.value,
    );
    if (result == null) return;
    await applyFilters(result);
  }
}
