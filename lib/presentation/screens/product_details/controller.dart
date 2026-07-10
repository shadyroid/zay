import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/cart_use_case.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/app/use_cases/reviews_use_case.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/app/utils/image_picker_helper.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/domain/models/beans/review_bean.dart';
import 'package:zay/domain/requests/add_cart_item_request.dart';
import 'package:zay/domain/requests/product_details_request.dart';
import 'package:zay/domain/requests/product_id_request.dart';
import 'package:zay/domain/requests/products_request.dart';
import 'package:zay/domain/requests/reviews_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class ProductDetailsController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final CartUseCase _cartUseCase = Get.put(CartUseCase());
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());

  final scrollController = ScrollController();
  final sizeGuideKey = GlobalKey();

  final product = Rxn<ProductBean>();
  final reviews = <ReviewBean>[].obs;
  final similarProducts = <ProductBean>[].obs;
  final quantity = 1.obs;
  Map<int, int> selectedSizesQuantities = {};
  final selectedSizeId = RxnInt();
  final isDescriptionExpanded = false.obs;
  final imageIndex = 0.obs;

  late final int productId;

  final RxBool isTryOnLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['productId'];
    _loadScreen();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _loadScreen() async {
    await Future.wait([
      requestProductDetails(),
      requestReviews(),
      requestSimilarProducts(),
    ]);
  }

  Future<void> requestProductDetails({bool isLoading = true}) async {
    this.isLoading.value = isLoading;
    final response = await _productsUseCase.requestProductDetails(
      ProductDetailsRequest(productId: productId),
    );
    this.isLoading.value = false;
    if (!isSuccess(response)) return;
    product.value = response.data;
    if (response.data != null) {
      selectedSizesQuantities = response.data?.selectedSizesQuantities ?? {};
      if (selectedSizeId.value != null) {
        quantity.value =  selectedSizesQuantities[selectedSizeId.value!]??1;

      }


    }
  }

  Future<void> requestReviews() async {
    final response = await _reviewsUseCase.requestReviews(
      ReviewsRequest(productId: productId),
    );
    if (!isSuccess(response)) return;
    reviews.assignAll(response.data ?? []);
  }

  Future<void> requestSimilarProducts() async {
    final response = await _productsUseCase.requestProducts(
      ProductsRequest(similarToId: productId, pageSize: 6),
    );
    if (!isSuccess(response)) return;
    similarProducts.assignAll(
      (response.data ?? []).where((p) => p.id != productId).take(6).toList(),
    );
  }

  Future<void> toggleFavorite() async {
    final p = product.value;
    if (p == null) return;
    await toggleFavoriteFor(p);
  }

  Future<void> toggleFavoriteFor(ProductBean item) async {
    if (!await AppAuthGuard.ensureAuthenticated()) return;

    final response = item.isFavorite.value
        ? await _productsUseCase.requestUnFavorite(
            ProductIdRequest(productId: item.id),
          )
        : await _productsUseCase.requestFavorite(
            ProductIdRequest(productId: item.id),
          );
    if (!isSuccess(response)) return;
  }

  void incrementQuantity() {
    if (selectedSizeId.value == null) {
      Get.rawSnackbar(message: 'selectSizeFirst'.tr);
      return;
    }

    quantity.value++;
    selectedSizesQuantities[selectedSizeId.value!] = quantity.value;
  }

  void decrementQuantity() {
    if (selectedSizeId.value == null) {
      Get.rawSnackbar(message: 'selectSizeFirst'.tr);
      return;
    }

    if (quantity.value > 1) {
      quantity.value--;
      selectedSizesQuantities[selectedSizeId.value!] = quantity.value;
    }
  }

  void selectSize(int? sizeId) {
    selectedSizeId.value = sizeId;
    quantity.value = selectedSizesQuantities[sizeId] ?? 1;
  }

  void toggleDescription() =>
      isDescriptionExpanded.value = !isDescriptionExpanded.value;

  void onImageChanged(int index) => imageIndex.value = index;

  void scrollToSizeGuide() {
    final context = sizeGuideKey.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> onTryOn() async {
    if (!await AppAuthGuard.ensureAuthenticated()) return;

    isTryOnLoading.value = true;
    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null) return;
    await AppAuthGuard.toNamed(
      Routes.tryOn,
      arguments: {'file': file, 'product': product.value},
    );
    isTryOnLoading.value = false;

  }

  Future<void> addToCart() async {
    if (!await AppAuthGuard.ensureAuthenticated()) return;

    final p = product.value;
    final sizeId = selectedSizeId.value;
    if (p == null) return;

    if (p.sizes?.isNotEmpty == true && sizeId == null) {
      Get.rawSnackbar(message: 'selectSizeRequired'.tr);
      return;
    }

    isLoading.value = true;
    final response = await _cartUseCase.requestAddCartItem(
      AddCartItemRequest(
        productId: productId,
        productSizeId: sizeId,
        quantity: quantity.value,
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.rawSnackbar(message: 'addedToCart'.tr);
    await AppAuthGuard.toNamed(Routes.cart);
    requestProductDetails(isLoading: false);
  }

  void navigateToShop() {
    final shopId = product.value?.shop?.id;
    if (shopId == null) return;
    Get.toNamed(Routes.shopDetails, arguments: {'shopId': shopId});
  }

  void navigateToProduct(ProductBean item) {
    Get.toNamed(Routes.productDetails, arguments: {'productId': item.id});
  }

  void onShare() {
    Get.rawSnackbar(message: 'shareComingSoon'.tr);
  }

  void onSeeAllReviews() {
    Get.toNamed(
      Routes.reviews,
      arguments: {'productId': productId, 'reviews': reviews.toList()},
    );
  }
}
