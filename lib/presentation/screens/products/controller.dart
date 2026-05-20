import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/utils/product_sort_option.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/beans/product_filters.dart';
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

  final List<ProductBean> _sourceProducts = [];

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

  Future<void> requestProducts() async {
    isLoading.value = true;
    final categoryId =
        selectedCategoryId.value == 'all' ? null : selectedCategoryId.value;
    final response =
        await _productsUseCase.requestProducts(categoryId: categoryId);
    isLoading.value = false;
    if (!isSuccess(response)) return;
    _sourceProducts
      ..clear()
      ..addAll(response.data ?? []);
    _syncFavoriteIds(response.data ?? []);
    _applyFiltersAndSort();
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

  void _applyFiltersAndSort() {
    final filters = activeFilters.value;
    var filtered = List<ProductBean>.from(_sourceProducts);

    if (filters.shopId != null) {
      filtered =
          filtered.where((p) => p.shopId == filters.shopId).toList();
    }
    if (filters.sizeId != null) {
      filtered =
          filtered.where((p) => p.sizeId == filters.sizeId).toList();
    }
    filtered = filtered
        .where((p) {
          final price = _price(p);
          return price >= filters.priceMin && price <= filters.priceMax;
        })
        .toList();

    totalCount.value = filtered.length;
    _sortAndAssign(filtered);
  }

  void _applySort() => _applyFiltersAndSort();

  void _sortAndAssign(List<ProductBean> list) {
    final sorted = List<ProductBean>.from(list);
    switch (selectedSort.value) {
      case ProductSortOption.priceHighToLow:
        sorted.sort((a, b) => _price(b).compareTo(_price(a)));
      case ProductSortOption.priceLowToHigh:
        sorted.sort((a, b) => _price(a).compareTo(_price(b)));
      case ProductSortOption.popularity:
        sorted.sort((a, b) => _rating(b).compareTo(_rating(a)));
      case ProductSortOption.discount:
        sorted.sort((a, b) => a.id.compareTo(b.id));
      case ProductSortOption.customerRating:
        sorted.sort((a, b) => _rating(b).compareTo(_rating(a)));
    }
    products.assignAll(sorted);
  }

  Future<void> onSort() async {
    final option = await SortBottomSheet.show(
      selectedOption: selectedSort.value,
    );
    if (option == null || option == selectedSort.value) return;
    selectedSort.value = option;
    _applySort();
  }

  double _price(ProductBean product) => double.tryParse(product.price) ?? 0;

  double _rating(ProductBean product) => double.tryParse(product.rating ?? '') ?? 0;

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
