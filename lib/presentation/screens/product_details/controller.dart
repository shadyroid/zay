import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/services/favorite_products_service.dart';
import 'package:hedma/app/use_cases/cart_use_case.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/use_cases/reviews_use_case.dart';
import 'package:hedma/app/utils/image_picker_helper.dart';
import 'package:hedma/app/utils/app_auth_guard.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/requests/add_cart_item_request.dart';
import 'package:hedma/domain/requests/product_details_request.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/domain/requests/reviews_request.dart';
import 'package:hedma/domain/requests/try_product_request.dart';
import 'package:hedma/domain/models/beans/review_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ProductDetailsController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final CartUseCase _cartUseCase = Get.put(CartUseCase());
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());
  final FavoriteProductsService _favorites = Get.find<FavoriteProductsService>();

  final scrollController = ScrollController();
  final sizeGuideKey = GlobalKey();

  final product = Rxn<ProductBean>();
  final reviews = <ReviewBean>[].obs;
  final similarProducts = <ProductBean>[].obs;
  final quantity = 1.obs;
  final selectedSizeId = RxnString();
  final isDescriptionExpanded = false.obs;
  final imageIndex = 0.obs;

  late final String productId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final passed = args['product'] as ProductBean?;
    productId = args['productId'] as String? ?? passed?.id ?? '';
    if (passed != null) {
      product.value = passed;
      _initSelectedSize(passed);
    }
    _loadScreen();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _loadScreen() async {
    await _favorites.ensureLoaded();
    await Future.wait([
      requestProductDetails(),
      requestReviews(),
    ]);
  }

  void _initSelectedSize(ProductBean p) {
    if (p.sizes.isEmpty) return;
    final match = p.sizeId != null
        ? p.sizes.where((s) => s.id == p.sizeId).firstOrNull
        : null;
    final fallback = p.sizes.where((s) => s.isAvailable).firstOrNull ??
        p.sizes.first;
    final selected = match != null && match.isAvailable ? match : fallback;
    selectedSizeId.value = selected.id;
  }

  Future<void> requestProductDetails() async {
    if (productId.isEmpty) return;
    isLoading.value = true;
    final response = await _productsUseCase.requestProductDetails(
      ProductDetailsRequest(productId: productId),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    product.value = response.data;
    if (response.data != null) {
      _initSelectedSize(response.data!);
      if (response.data!.isFavorite) {
        _favorites.favoriteIds.add(productId);
      }
    }
    final similar = response.similarProducts;
    if (similar != null && similar.isNotEmpty) {
      similarProducts.assignAll(similar);
    } else {
      await requestSimilarProducts();
    }
  }

  Future<void> requestReviews() async {
    if (productId.isEmpty) return;
    final response = await _reviewsUseCase.requestReviews(
      ReviewsRequest(productId: productId),
    );
    if (!isSuccess(response)) return;
    reviews.assignAll(response.data ?? []);
  }

  Future<void> requestSimilarProducts() async {
    final response = await _productsUseCase.requestProducts(
      request: ProductsRequest(
        similarToId: productId,
        pageSize: 6,
      ),
    );
    if (!isSuccess(response)) return;
    similarProducts.assignAll(
      (response.data ?? [])
          .where((p) => p.id != productId)
          .take(6)
          .toList(),
    );
  }

  bool get isFavorite {
    final p = product.value;
    if (p == null) return false;
    return _favorites.isFavoriteProduct(p);
  }

  Future<void> toggleFavorite() async {
    final p = product.value;
    if (p == null) return;
    await toggleFavoriteFor(p);
    product.refresh();
  }

  Future<void> toggleFavoriteFor(ProductBean item) =>
      _favorites.toggleFavorite(item);

  void incrementQuantity() => quantity.value++;

  void decrementQuantity() {
    if (quantity.value > 1) quantity.value--;
  }

  void selectSize(String sizeId) => selectedSizeId.value = sizeId;

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

    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null || productId.isEmpty) return;

    isLoading.value = true;
    final response = await _productsUseCase.requestTryProduct(
      TryProductRequest(productId: productId, imagePath: file.path),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    final imageUrl = response.imageUrl;
    if (imageUrl == null || imageUrl.isEmpty) return;

    await AppAuthGuard.toNamed(
      Routes.tryOn,
      arguments: {
        'imageUrl': imageUrl,
        'productId': productId,
        'productPrice': product.value?.price,
        'productName': product.value?.name,
      },
    );
  }

  Future<void> addToCart() async {
    if (!await AppAuthGuard.ensureAuthenticated()) return;

    final p = product.value;
    final sizeId = selectedSizeId.value;
    if (p == null || productId.isEmpty) return;

    if (p.sizes.isNotEmpty && (sizeId == null || sizeId.isEmpty)) {
      Get.rawSnackbar(message: 'selectSizeRequired'.tr);
      return;
    }

    isLoading.value = true;
    final response = await _cartUseCase.requestAddCartItem(
      AddCartItemRequest(
        productId: productId,
        productSizeId: sizeId ?? '',
        quantity: quantity.value,
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.rawSnackbar(message: 'addedToCart'.tr);
    await AppAuthGuard.toNamed(Routes.cart);
  }

  void navigateToShop() {
    final shopId = product.value?.shopId;
    if (shopId == null) return;
    Get.toNamed(Routes.shopDetails, arguments: {'shopId': shopId});
  }

  void navigateToProduct(ProductBean item) {
    Get.toNamed(
      Routes.productDetails,
      arguments: {'productId': item.id, 'product': item},
    );
  }

  void onShare() {
    Get.rawSnackbar(message: 'shareComingSoon'.tr);
  }

  void onSeeAllReviews() {
    Get.toNamed(
      Routes.reviews,
      arguments: {
        'productId': productId,
        'reviews': reviews.toList(),
      },
    );
  }

  void goBack() => Get.back();
}
