import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/cart_use_case.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/app/use_cases/reviews_use_case.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/app/utils/image_picker_helper.dart';
import 'package:zay/app/utils/transfer_progress.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/domain/models/requests/add_cart_item_request.dart';
import 'package:zay/domain/models/requests/product_details_request.dart';
import 'package:zay/domain/models/requests/try_on_details_request.dart';
import 'package:zay/domain/models/requests/try_on_request.dart';
import 'package:zay/domain/models/requests/try_on_review_request.dart';
import 'package:zay/presentation/base/base_controller.dart';
import 'package:zay/presentation/bottom_sheets/try_on_image_actions/try_on_image_action.dart';
import 'package:zay/presentation/bottom_sheets/try_on_image_actions/try_on_image_actions_bottom_sheet.dart';

class TryOnController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());
  final CartUseCase _cartUseCase = Get.put(CartUseCase());

  XFile? file;
  final imageUrl = RxnString();
  int? tryOnId;
  int? productId;
  late ProductBean product;
  final selectedSizeId = RxnInt();
  int quantity = 1;
  final selectedRating = 1.obs;
  final sendProgress = 0.0.obs;
  final receiveProgress = 0.0.obs;
  final isGenerating = false.obs;
  final allowedTriesToday = RxnInt();
  final isImageActionLoading = false.obs;
  final isAddingToCart = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    file = Get.arguments?['file'] as XFile?;
    final argProduct = Get.arguments?['product'];
    if (argProduct is ProductBean) {
      product = argProduct;
      productId = argProduct.id;
    }
    tryOnId = _parseInt(Get.arguments?['tryOnId']);
    productId = _parseInt(Get.arguments?['productId']) ?? productId;

    if (tryOnId != null && file == null) {
      requestTryOnDetails();
    } else {
      requestTryOn();
    }
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  void selectSize(int? sizeId) {
    if (sizeId != null) {
      final matched = product.sizes?.where((s) => s.id == sizeId);
      if (matched != null &&
          matched.isNotEmpty &&
          matched.first.isOutOfStock == true) {
        return;
      }
    }
    selectedSizeId.value = sizeId;
    quantity = product.selectedSizesQuantities?[sizeId] ?? 1;
  }

  void openSizeGuide() {
    final sizes = product.sizes;
    if (sizes == null || sizes.isEmpty) return;
    Get.toNamed(
      Routes.sizeGuide,
      arguments: {
        'sizes': sizes,
        'measurementsImage': product.category?.measurementsImage,
      },
    );
  }

  void selectRating(int rating) {
    selectedRating.value = rating;
    _submitFitRating(rating);
  }

  Future<void> _submitFitRating(int rating) async {
    await _reviewsUseCase.requestTryOnReview(
      TryOnReviewRequest(tryOnId: tryOnId, rate: rating),
    );
  }

  Future<void> onTryOnAgain() async {
    final picked = await ImagePickerHelper.pickFromBottomSheet();
    if (picked == null) return;
    file = picked;
    requestTryOn();
  }

  Future<void> requestTryOnDetails() async {
    isLoading.value = true;
    isGenerating.value = false;
    final id = tryOnId;
    final pid = productId;
    if (id == null || pid == null) {
      Get.back();
      return;
    }

    final productResponse = await _productsUseCase.requestProductDetails(
      ProductDetailsRequest(productId: pid),
    );
    if (!productResponse.isSuccess || productResponse.data == null) {
      isLoading.value = false;
      if (!isSuccess(productResponse)) {
        Get.back();
        return;
      }
      Get.back();
      return;
    }
    product = productResponse.data!;

    final response = await _productsUseCase.requestTryOnDetails(
      TryOnDetailsRequest(tryOnId: id),
    );
    isLoading.value = false;
    if (!response.isSuccess) {
      Get.back();
      isSuccess(response);
      return;
    }

    tryOnId = response.id ?? id;
    allowedTriesToday.value = response.allowedTriesToday;
    final url = response.imageUrl;
    if (url != null && url.isNotEmpty) {
      imageUrl.value = url;
    }
  }

  Future<void> requestTryOn() async {
    final image = file;
    if (image == null) {
      Get.back();
      return;
    }
    isLoading.value = true;
    isGenerating.value = true;
    sendProgress.value = 0;
    receiveProgress.value = 0;
    final response = await _productsUseCase.requestTryOn(
      TryOnRequest(productId: product.id ?? productId, image: image),
      onSendProgress: (count, total) {
        final next = TransferProgress.portion(count, total);
        if (next > sendProgress.value) sendProgress.value = next;
      },
      onReceiveProgress: (count, total) {
        sendProgress.value = 1;
        final next = TransferProgress.portion(count, total);
        if (next > receiveProgress.value) receiveProgress.value = next;
      },
    );
    sendProgress.value = 1;
    receiveProgress.value = 1;
    isGenerating.value = false;
    isLoading.value = false;

    // If first try fails, go back
    if (!response.isSuccess && imageUrl.value == null) Get.back();
    if (!isSuccess(response)) return;

    tryOnId = response.id;
    allowedTriesToday.value = response.allowedTriesToday;
    final url = response.imageUrl;
    if (url != null && url.isNotEmpty) {
      imageUrl.value = url;
    }
  }

  Future<void> onAddToCart() async {
    if (isAddingToCart.value) return;
    if (!await AppAuthGuard.ensureAuthenticated()) return;

    final p = product;
    final productId = p.id;
    final sizeId = selectedSizeId.value;
    if (productId == null) return;

    if (p.isOutOfStock == true) {
      Get.rawSnackbar(message: 'outOfStock'.tr);
      return;
    }

    if (p.sizes?.isNotEmpty == true && sizeId == null) {
      Get.rawSnackbar(message: 'selectSizeRequired'.tr);
      return;
    }

    final selectedSize = p.sizes?.where((s) => s.id == sizeId);
    if (selectedSize != null &&
        selectedSize.isNotEmpty &&
        selectedSize.first.isOutOfStock == true) {
      Get.rawSnackbar(message: 'outOfStock'.tr);
      return;
    }

    isAddingToCart.value = true;
    final response = await _cartUseCase.requestAddCartItem(
      AddCartItemRequest(
        productId: productId,
        productSizeId: sizeId,
        quantity: quantity,
      ),
    );
    isAddingToCart.value = false;
    if (!isSuccess(response)) return;

    Get.rawSnackbar(message: 'addedToCart'.tr);
    await AppAuthGuard.toNamed(Routes.cart);
  }

  Future<void> onShare() async {
    if (isImageActionLoading.value) return;
    final url = imageUrl.value;
    if (url == null || url.isEmpty) {
      Get.rawSnackbar(message: 'tryOnImageUnavailable'.tr);
      return;
    }

    final action = await TryOnImageActionsBottomSheet.show();
    if (action == null) return;

    switch (action) {
      case TryOnImageAction.share:
        await _shareImage();
      case TryOnImageAction.download:
        await _downloadImage();
    }
  }

  Future<void> _shareImage() async {
    isImageActionLoading.value = true;
    final bytes = await _fetchImageBytes();
    isImageActionLoading.value = false;
    if (bytes == null) return;

    try {
      final dir = await getTemporaryDirectory();
      final path =
          '${dir.path}/zay_try_on_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = await File(path).writeAsBytes(bytes, flush: true);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'image/jpeg')],
          subject: 'virtualTryOn'.tr,
        ),
      );
    } catch (_) {
      Get.rawSnackbar(message: 'tryOnImageShareFailed'.tr);
    }
  }

  Future<void> _downloadImage() async {
    isImageActionLoading.value = true;
    final bytes = await _fetchImageBytes();
    if (bytes == null) {
      isImageActionLoading.value = false;
      return;
    }

    try {
      await Gal.putImageBytes(
        bytes,
        name: 'zay_try_on_${DateTime.now().millisecondsSinceEpoch}',
      );
      Get.rawSnackbar(message: 'imageSavedToGallery'.tr);
    } on GalException {
      Get.rawSnackbar(message: 'tryOnImageSaveFailed'.tr);
    } catch (_) {
      Get.rawSnackbar(message: 'tryOnImageSaveFailed'.tr);
    } finally {
      isImageActionLoading.value = false;
    }
  }

  Future<Uint8List?> _fetchImageBytes() async {
    final url = imageUrl.value;
    if (url == null || url.isEmpty) {
      Get.rawSnackbar(message: 'tryOnImageUnavailable'.tr);
      return null;
    }

    try {
      final response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      final data = response.data;
      if (data == null || data.isEmpty) {
        Get.rawSnackbar(message: 'tryOnImageUnavailable'.tr);
        return null;
      }
      return Uint8List.fromList(data);
    } catch (_) {
      Get.rawSnackbar(message: 'tryOnImageUnavailable'.tr);
      return null;
    }
  }
}
