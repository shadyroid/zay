import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/use_cases/shops_use_case.dart';
import 'package:hedma/app/utils/app_auth_guard.dart';
import 'package:hedma/app/utils/image_picker_helper.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/domain/requests/product_id_request.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';
import 'package:hedma/presentation/bottom_sheets/filter/filter_bottom_sheet.dart';

class HomeController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final searchController = TextEditingController();
  final userName = ''.obs;
  final profileImagePath = RxnString();
  final categories = <CategoryBean>[].obs;
  final recommendedProducts = <ProductBean>[].obs;
  final newArrivalProducts = <ProductBean>[].obs;
  final topStores = <ShopBean>[].obs;
  final selectedCategoryId = RxnInt();

  final Map<int?, String?> _shopNames = {};

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
    await Future.wait([
      if (PrefsManager.isLoggedIn) _requestProfile(),
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
    profileImagePath.value = response.data?.avatarUrl;
  }

  Future<void> _requestCategories() async {
    final response = await _productsUseCase.requestCategories();
    if (!isSuccess(response)) return;
    categories.assignAll(response.data ?? []);
  }

  Future<void> _requestRecommended() async {
    final response = await _productsUseCase.requestProducts(
      ProductsRequest(recommended: true, pageSize: 4),
    );
    if (!isSuccess(response)) return;
    recommendedProducts.assignAll(response.data ?? []);
  }

  Future<void> _requestNewArrivals() async {
    final response = await _productsUseCase.requestProducts(
      ProductsRequest(newArrival: true, pageSize: 6),
    );
    if (!isSuccess(response)) return;
    newArrivalProducts.assignAll(response.data ?? []);
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

  void onSearchSubmit() {
    final query = searchController.text.trim();
    var search = query.isEmpty ? null : query;
    Get.toNamed(Routes.products, arguments: {'search': search});
  }

  void onSearchIconTap() => onSearchSubmit();

  Future<void> onCameraTap() async {
    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null) return;
    Get.toNamed(Routes.products,arguments: {'image':file});
  }

  Future<void> onFilterTap() async {
    final result = await FilterBottomSheet.show();
    if (result == null) return;
    Get.toNamed(Routes.products, arguments: result);
  }

  void onCategoryTap(CategoryBean category) {
    Get.toNamed(Routes.products, arguments: {'categoryId': category.id});
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': product.id});
  }

  void onSeeAllRecommended() => Get.toNamed(Routes.products);

  void onSeeAllNewArrival() => Get.toNamed(Routes.products);

  void onSeeAllStores() => Get.toNamed(Routes.shops);

  void onStoreTap(ShopBean shop) {
    Get.toNamed(Routes.shopDetails, arguments: {'shopId': shop.id});
  }
}
