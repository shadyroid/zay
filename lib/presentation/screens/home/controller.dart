import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/use_cases/shops_use_case.dart';
import 'package:hedma/app/utils/image_picker_helper.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/beans/product_filters.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';
import 'package:hedma/presentation/bottom_sheets/filter/filter_bottom_sheet.dart';
import 'package:hedma/presentation/screens/products/controller.dart';

class HomeController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());
  final FavoriteProductsService _favorites = Get.find<FavoriteProductsService>();

  final searchController = TextEditingController();
  final userName = ''.obs;
  final categories = <CategoryBean>[].obs;
  final recommendedProducts = <ProductBean>[].obs;
  final newArrivalProducts = <ProductBean>[].obs;
  final topStores = <ShopBean>[].obs;
  final selectedCategoryId = 'all'.obs;

  final Map<String, String> _shopNames = {};

  @override
  void onInit() {
    super.onInit();
    _loadScreen();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> _loadScreen() async {
    isLoading.value = true;
    await _favorites.ensureLoaded();
    await Future.wait([
      _requestProfile(),
      _requestCategories(),
      _requestRecommended(),
      _requestNewArrivals(),
      _requestTopStores(),
    ]);
    isLoading.value = false;
  }

  Future<void> _requestProfile() async {
    final response = await _authUseCase.requestProfile();
    if (!isSuccess(response)) return;
    userName.value = response.data?.name ?? '';
  }

  Future<void> _requestCategories() async {
    final response = await _productsUseCase.requestCategories();
    if (!isSuccess(response)) return;
    categories.assignAll(response.data ?? []);
  }

  Future<void> _requestRecommended() async {
    final response = await _productsUseCase.requestProducts(
      request: const ProductsRequest(recommended: true, pageSize: 4),
    );
    if (!isSuccess(response)) return;
    recommendedProducts.assignAll(response.data ?? []);
    _syncFavorites(response.data ?? []);
  }

  Future<void> _requestNewArrivals() async {
    final response = await _productsUseCase.requestProducts(
      request: const ProductsRequest(newArrival: true, pageSize: 6),
    );
    if (!isSuccess(response)) return;
    newArrivalProducts.assignAll(response.data ?? []);
    _syncFavorites(response.data ?? []);
  }

  Future<void> _requestTopStores() async {
    final response = await _shopsUseCase.requestShops();
    if (!isSuccess(response)) return;
    final shops = response.data ?? [];
    topStores.assignAll(shops.take(4));
    _shopNames
      ..clear()
      ..addEntries(shops.map((s) => MapEntry(s.id, s.name)));
  }

  void _syncFavorites(List<ProductBean> list) {
    for (final product in list) {
      if (product.isFavorite) {
        _favorites.favoriteIds.add(product.id);
      }
    }
  }

  String shopNameFor(ProductBean product) {
    if (product.shopId == null) return '';
    return _shopNames[product.shopId] ?? '';
  }

  bool isFavorite(ProductBean product) => _favorites.isFavoriteProduct(product);

  Future<void> toggleFavorite(ProductBean product) =>
      _favorites.toggleFavorite(product);

  void navigateToProducts({
    String? categoryId,
    ProductFilters? filters,
  }) {
    if (Get.isRegistered<ProductsController>()) {
      Get.delete<ProductsController>();
    }
    Get.toNamed(
      Routes.products,
      arguments: <String, dynamic>{
        'categoryId': categoryId,
        'filters': filters,
      },
    );
  }

  void onSearchSubmit() => navigateToProducts();

  void onSearchIconTap() => navigateToProducts();

  Future<void> onCameraTap() async {
    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null) return;
    navigateToProducts();
  }

  Future<void> onFilterTap() async {
    final result = await FilterBottomSheet.show(
      initial: ProductFilters.initial,
    );
    if (result == null) return;
    navigateToProducts(filters: result);
  }

  void onCategoryTap(CategoryBean category) {
    navigateToProducts(categoryId: category.id);
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }

  void onSeeAllRecommended() => navigateToProducts();

  void onSeeAllNewArrival() => navigateToProducts();

  void onSeeAllStores() => Get.toNamed(Routes.shops);

  void onStoreTap(ShopBean shop) {
    Get.toNamed(Routes.shopDetails, arguments: {'shopId': shop.id});
  }
}
