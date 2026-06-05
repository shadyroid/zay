import 'dart:io';

import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/use_cases/reviews_use_case.dart';
import 'package:hedma/app/utils/app_auth_guard.dart';
import 'package:hedma/app/utils/image_picker_helper.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/requests/add_try_out_review_request.dart';
import 'package:hedma/domain/requests/try_product_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';
import 'package:image_picker/image_picker.dart';

class TryOnController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());

  late XFile file;
  final imageUrl = RxnString();
  late ProductBean product;
  final selectedRating = 1.obs;

  @override
  void onInit() {
    super.onInit();
    file = Get.arguments['file'];
    product = Get.arguments['product'];
  }

  void selectRating(int rating) {
    selectedRating.value = rating;
    _submitFitRating(rating);
  }

  Future<void> _submitFitRating(int rating) async {
    await _reviewsUseCase.requestAddTryOutReview(
      AddTryOutReviewRequest(
        productId: product.id,
        title: 'tryOnFitRating'.tr,
        comment: 'tryOnFitRatingComment'.tr,
        rating: rating.toDouble(),
      ),
    );
    // Rating is optional feedback; failures are not surfaced to avoid interrupting try-on.
  }

  Future<void> onTryOnAgain() async {
    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null) return;
    requestTryProduct();
  }
  Future<void> requestTryProduct() async {
    isLoading.value = true;
    final response = await _productsUseCase.requestTryProduct(
      TryProductRequest(productId: product.id, image: file),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    final url = response.imageUrl;
    if (url != null && url.isNotEmpty) {
      imageUrl.value = url;
    }
  }
  Future<void> onAddToCart() async {
    if (!await AppAuthGuard.ensureAuthenticated()) return;
    Get.rawSnackbar(message: 'addedToCart'.tr);
    await AppAuthGuard.toNamed(Routes.cart);
  }

  void onShare() {
    Get.rawSnackbar(message: 'shareComingSoon'.tr);
  }
}
