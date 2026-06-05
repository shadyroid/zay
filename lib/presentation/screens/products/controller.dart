import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/utils/app_auth_guard.dart';
import 'package:hedma/app/utils/product_sort_option.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/requests/product_id_request.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';
import 'package:hedma/presentation/bottom_sheets/filter/filter_bottom_sheet.dart';
import 'package:hedma/presentation/bottom_sheets/sort/sort_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class ProductsController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());

  final categories = <CategoryBean>[].obs;
  final products = <ProductBean>[].obs;
  final selectedCategoryId = RxnInt();
  final selectedSort = Rxn<ProductSortOption>();
  final searchQuery = RxnString();
  final totalCount = 0.obs;

  int? shopId;
  int? sizeId;
  double? priceMin;
  double? priceMax;
  XFile? image;

  @override
  void onInit() {
    super.onInit();
    selectedCategoryId.value = Get.arguments['categoryId'];
    searchQuery.value = Get.arguments['search'];
    shopId = Get.arguments['shopId'];
    image = Get.arguments['image'];
    requestCategories();
    requestProducts();
  }

  Future<void> requestCategories() async {
    final response = await _productsUseCase.requestCategories();
    if (!isSuccess(response)) return;
    categories.assignAll(response.data ?? []);
  }

  Future<void> requestProducts() async {
    isLoading.value = true;
    final response = await _productsUseCase.requestProducts(
      ProductsRequest(
        categoryId: selectedCategoryId.value,
        shopId: shopId,
        sizeId: sizeId,
        minPrice: priceMin,
        maxPrice: priceMax,
        sortBy: selectedSort.value,
        search: searchQuery.value,
        image: image,
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    products.assignAll(response.data ?? []);
    totalCount.value = response.totalCount ?? products.length;
  }

  void selectCategory(CategoryBean category) {
    if (selectedCategoryId.value == category.id) {
      selectedCategoryId.value = null;
    } else {
      selectedCategoryId.value = category.id;
    }
    requestProducts();
  }

  Future<void> onSortTap() async {
    final option = await SortBottomSheet.show(
      selectedOption: selectedSort.value,
    );
    if (option == null || option == selectedSort.value) return;
    selectedSort.value = option;
    requestProducts();
  }

  Future<void> toggleFavorite(ProductBean product) async {
    if (!await AppAuthGuard.ensureAuthenticated()) return;

    final response = product.isFavorite.value
        ? await _productsUseCase.requestUnFavorite(
            ProductIdRequest(productId: product.id),
          )
        : await _productsUseCase.requestFavorite(
            ProductIdRequest(productId: product.id),
          );
    if (!isSuccess(response)) return;
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }

  void onSearch() {
    Get.rawSnackbar(message: 'searchComingSoon'.tr);
  }

  Future<void> onFilters() async {
    final result = await FilterBottomSheet.show(
      categoryId: selectedCategoryId.value,
      shopId: shopId,
      sizeId: sizeId,
      priceMin: priceMin,
      priceMax: priceMax,
    );
    if (result == null) return;
    selectedCategoryId.value = result['categoryId'];
    shopId = result['shopId'];
    sizeId = result['sizeId'];
    priceMin = result['priceMin'];
    priceMax = result['priceMax'];
    requestProducts();
  }
}
