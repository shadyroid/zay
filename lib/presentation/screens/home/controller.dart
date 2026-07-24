import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/ads_use_case.dart';
import 'package:zay/app/use_cases/auth_use_case.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/app/use_cases/shops_use_case.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/app/utils/image_picker_helper.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/domain/models/beans/ad_bean.dart';
import 'package:zay/domain/models/beans/category_bean.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/domain/models/requests/product_id_request.dart';
import 'package:zay/domain/models/requests/products_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class HomeController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());
  final AdsUseCase _adsUseCase = Get.put(AdsUseCase());

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final isSearchExpanded = false.obs;
  final userName = ''.obs;
  final profileImagePath = RxnString();
  final ads = <AdBean>[].obs;
  final currentAdIndex = 0.obs;
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
    searchFocusNode.dispose();
    super.onClose();
  }

  Future<void> _loadScreen() async {
    isLoading.value = true;
    await Future.wait([
      if (PrefsManager.isLoggedIn) _requestProfile(),
      _requestAds(),
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

  Future<void> _requestAds() async {
    final response = await _adsUseCase.requestAds();
    if (!isSuccess(response)) return;
    ads.assignAll(response.data ?? []);
  }

  Future<void> _requestCategories() async {
    final response = await _productsUseCase.requestCategories();
    if (!isSuccess(response)) return;
    if(response.data?.isNotEmpty == true) {
      categories.add(CategoryBean.fromJson({"name": "all_items".tr}));
      categories.addAll(response.data ?? []);
    }
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

  void onAdPageChanged(int index) => currentAdIndex.value = index;

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

  void onSearchToggle() {
    isSearchExpanded.toggle();
    if (isSearchExpanded.value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (isSearchExpanded.value) {
          searchFocusNode.requestFocus();
        }
      });
    } else {
      searchController.clear();
      searchFocusNode.unfocus();
    }
  }

  void onNotificationsTap() {
    Get.rawSnackbar(message: 'notificationsComingSoon'.tr);
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
