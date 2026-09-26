import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/ads_use_case.dart';
import 'package:zay/app/use_cases/auth_use_case.dart';
import 'package:zay/app/use_cases/notifications_use_case.dart';
import 'package:zay/app/use_cases/order_use_case.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/app/use_cases/shops_use_case.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/app/utils/image_picker_helper.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/domain/models/beans/ad_bean.dart';
import 'package:zay/domain/models/beans/category_bean.dart';
import 'package:zay/domain/models/beans/order_product_bean.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/domain/models/requests/order_details_request.dart';
import 'package:zay/domain/models/requests/product_id_request.dart';
import 'package:zay/domain/models/requests/products_request.dart';
import 'package:zay/presentation/base/base_controller.dart';
import 'package:zay/presentation/bottom_sheets/review/review_bottom_sheet.dart';
import 'package:zay/presentation/bottom_sheets/types/types_bottom_sheet.dart';
import 'package:zay/presentation/screens/home/home_sections_data.dart';
import 'package:zay/presentation/widgets/product_item.dart';

class HomeController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final ShopsUseCase _shopsUseCase = Get.put(ShopsUseCase());
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());
  final AdsUseCase _adsUseCase = Get.put(AdsUseCase());
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());
  final NotificationsUseCase _notificationsUseCase = Get.put(
    NotificationsUseCase(),
  );

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final scrollController = ScrollController();
  final recommendedProductsScrollController = ScrollController();
  final newArrivalProductsScrollController = ScrollController();
  final tryOnProductKey = GlobalKey();
  final isSearchExpanded = false.obs;
  final userName = ''.obs;
  final profileImagePath = RxnString();
  final unreadNotificationsCount = 0.obs;
  final ads = <AdBean>[].obs;
  final currentAdIndex = 0.obs;
  final categories = <CategoryBean>[].obs;
  final recommendedProducts = <ProductBean>[].obs;
  final newArrivalProducts = <ProductBean>[].obs;
  final topStores = <ShopBean>[].obs;
  final selectedCategoryId = RxnInt();
  final isLoadingAds = false.obs;
  final isLoadingCategories = false.obs;
  final isLoadingRecommended = false.obs;
  final isLoadingNewArrivals = false.obs;
  final isLoadingStores = false.obs;

  bool _isLoadInProgress = false;

  @override
  void onInit() {
    super.onInit();
    _loadScreen();
  }

  void onTabResumed() {
    if (_isLoadInProgress) return;
    if (PrefsManager.isLoggedIn) {
      _loadScreen();
      return;
    }
    if (PrefsManager.isLoggedIn) requestNotificationsCount();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    scrollController.dispose();
    recommendedProductsScrollController.dispose();
    newArrivalProductsScrollController.dispose();
    super.onClose();
  }

  Future<void> _loadScreen() async {
    if (_isLoadInProgress) return;
    _isLoadInProgress = true;

    if (!PrefsManager.isLoggedIn) {
      userName.value = '';
      profileImagePath.value = null;
      unreadNotificationsCount.value = 0;
    } else {
      _requestProfile();
      requestNotificationsCount();
      _requestLastReview();
    }
    _requestAds();
    _requestCategories();
    _requestRecommended();
    _requestNewArrivals();
    requestShops();
  }

  Future<void> _requestLastReview() async {
    var order = await _orderUseCase.requestLastReview();
    if (order == null || order.id == null) return;

    var items = order.items ?? const <OrderProductBean>[];
    if (items.isEmpty) {
      final response = await _orderUseCase.requestOrderDetails(
        OrderDetailsRequest(orderId: order.id!),
      );
      if (!isSuccess(response)) return;
      items = response.data?.items ?? const [];
    }

    OrderProductBean? item;
    for (final product in items) {
      if (!product.isReviewed) {
        item = product;
        break;
      }
    }
    if (item == null) return;

    await ReviewBottomSheet.show(orderId: order.id!, item: item);
  }

  Future<void> requestNotificationsCount() async {
    if (!PrefsManager.isLoggedIn) {
      unreadNotificationsCount.value = 0;
      return;
    }
    final response = await _notificationsUseCase.requestNotificationsCount();
    if (!isSuccess(response)) return;
    unreadNotificationsCount.value = response.unreadCount;
  }

  Future<void> _requestProfile() async {
    final response = await _authUseCase.requestProfile();
    if (!isSuccess(response)) return;
    userName.value = response.data?.name ?? '';
    profileImagePath.value = response.data?.avatarUrl;
  }

  Future<void> _requestAds() async {
    isLoadingAds.value = true;
    final response = await _adsUseCase.requestAds();
    isLoadingAds.value = false;
    if (!isSuccess(response)) return;
    ads.assignAll(response.data ?? []);
  }

  Future<void> _requestCategories() async {
    isLoadingCategories.value = true;
    final response = await _productsUseCase.requestCategories();
    isLoadingCategories.value = false;
    if (!isSuccess(response)) return;
    if (response.data?.isNotEmpty == true) {
      categories.assignAll([
        CategoryBean.fromJson({"name": "all_items".tr}),
        ...response.data!,
      ]);
    } else {
      categories.clear();
    }
  }

  Future<void> _requestRecommended() async {
    isLoadingRecommended.value = true;
    final response = await _productsUseCase.requestProducts(
      ProductsRequest(
        recommended: true,
        pageSize: ProductsRequest.pageSizeDefault,
        page: 1,
      ),
    );
    isLoadingRecommended.value = false;
    if (!isSuccess(response)) return;
    recommendedProducts.assignAll(response.data ?? []);
  }

  Future<void> _requestNewArrivals() async {
    isLoadingNewArrivals.value = true;
    final response = await _productsUseCase.requestProducts(
      ProductsRequest(
        newArrival: true,
        pageSize: ProductsRequest.pageSizeDefault,
        page: 1,
      ),
    );
    isLoadingNewArrivals.value = false;
    if (!isSuccess(response)) return;
    newArrivalProducts.assignAll(response.data ?? []);
  }

  Future<void> requestShops() async {
    isLoadingStores.value = true;
    final response = await _shopsUseCase.requestShops();
    isLoadingStores.value = false;
    if (!isSuccess(response)) return;
    final shops = response.data ?? [];
    topStores.assignAll(shops);
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

  HomeSectionsData get homeSections => HomeSectionsData(
    recommendedProducts: recommendedProducts.toList(),
    newArrivalProducts: newArrivalProducts.toList(),
  );

  Map<String, dynamic> _withHomeSections([Map<String, dynamic>? extra]) {
    return homeSections.mergeWith(extra ?? <String, dynamic>{});
  }

  void onSearchSubmit() {
    final query = searchController.text.trim();
    var search = query.isEmpty ? null : query;
    Get.toNamed(
      Routes.products,
      arguments: _withHomeSections({'search': search}),
    );
  }

  void onSearchIconTap() => onSearchSubmit();

  Future<void> onCameraTap() async {
    final type = await TypesBottomSheet.show();
    if (type == null) return;

    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null) return;

    Get.toNamed(
      Routes.products,
      arguments: _withHomeSections({'image': file, 'type': type.id}),
    );
  }

  void onSearchToggle({bool focus = true}) {
    isSearchExpanded.toggle();
    if (isSearchExpanded.value) {
      if (!focus) return;
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

  Future<void> startTryOnGuide(BuildContext context) async {
    final intro = Intro.of(context);
    if (intro.status.isOpen) return;

    final product = tryOnGuideProduct;
    if (product == null) return;

    final fromRecommended = isTryOnGuideInRecommended;
    final productsScroll = fromRecommended
        ? recommendedProductsScrollController
        : newArrivalProductsScrollController;
    final list = fromRecommended ? recommendedProducts : newArrivalProducts;
    final index = list.indexWhere((item) => item.id == product.id);

    if (productsScroll.hasClients && index >= 0) {
      const itemExtent = ProductItem.cardWidth + 12;
      final target = (index * itemExtent).clamp(
        0.0,
        productsScroll.position.maxScrollExtent,
      );
      await productsScroll.animateTo(
        target,
        duration: AppMotion.normal,
        curve: AppMotion.standard,
      );
    }

    await Future<void>.delayed(AppMotion.fast);
    if (!context.mounted) return;

    final productContext = tryOnProductKey.currentContext;
    if (productContext != null) {
      await Scrollable.ensureVisible(
        productContext,
        alignment: 0.15,
        duration: AppMotion.normal,
        curve: AppMotion.standard,
      );
    }

    await Future<void>.delayed(AppMotion.fast);
    if (!context.mounted) return;
    intro.start(group: 'tryOn', reset: true);
  }

  ProductBean? get tryOnGuideProduct {
    return _firstTryOnProduct(recommendedProducts) ??
        _firstTryOnProduct(newArrivalProducts);
  }

  bool get isTryOnGuideInRecommended {
    final product = tryOnGuideProduct;
    if (product?.id == null) return false;
    return recommendedProducts.any((item) => item.id == product!.id);
  }

  bool isTryOnGuideTarget(
    ProductBean product, {
    required bool fromRecommended,
  }) {
    final target = tryOnGuideProduct;
    if (target?.id == null || product.id != target!.id) return false;
    return fromRecommended == isTryOnGuideInRecommended;
  }

  ProductBean? _firstTryOnProduct(List<ProductBean> products) {
    for (final product in products) {
      if (product.category?.isTryOnEnabled == true) return product;
    }
    return null;
  }

  void openTryOnGuideProduct() {
    final product = tryOnGuideProduct;
    if (product?.id == null) return;
    Get.toNamed(
      Routes.productDetails,
      arguments: _withHomeSections({
        'productId': product!.id,
        'startTryOnIntro': true,
      }),
    );
  }

  Future<void> startSearchByImageGuide(BuildContext context) async {
    final intro = Intro.of(context);
    if (intro.status.isOpen) return;
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        0,
        duration: AppMotion.normal,
        curve: AppMotion.standard,
      );
    }
    if (!isSearchExpanded.value) {
      onSearchToggle(focus: false);
      await Future<void>.delayed(AppMotion.normal);
    }
    if (!context.mounted) return;
    intro.start(group: 'searchByImage', reset: true);
  }

  Future<void> onNotificationsTap() async {
    await AppAuthGuard.toNamed(Routes.notifications);
    await requestNotificationsCount();
  }

  void onCategoryTap(CategoryBean category) {
    Get.toNamed(
      Routes.products,
      arguments: _withHomeSections({'categoryId': category.id}),
    );
  }

  void navigateToProductDetails(ProductBean product) {
    Get.toNamed(
      Routes.productDetails,
      arguments: _withHomeSections({'productId': product.id}),
    );
  }

  void onSeeAllRecommended() =>
      Get.toNamed(Routes.products, arguments: _withHomeSections());

  void onSeeAllNewArrival() =>
      Get.toNamed(Routes.products, arguments: _withHomeSections());

  void onSeeAllStores() => Get.toNamed(Routes.shops);

  void onStoreTap(ShopBean shop) {
    Get.toNamed(Routes.shopDetails, arguments: {'shopId': shop.id});
  }
}
