import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/products_use_case.dart';
import 'package:hedma/app/use_cases/reviews_use_case.dart';
import 'package:hedma/app/utils/image_picker_helper.dart';
import 'package:hedma/domain/requests/add_try_out_review_request.dart';
import 'package:hedma/domain/requests/try_product_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class TryOnController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());

  final imageUrl = ''.obs;
  final productId = ''.obs;
  final productPrice = ''.obs;
  final productName = ''.obs;
  final selectedRating = 1.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    imageUrl.value = args['imageUrl'] as String? ?? '';
    productId.value = args['productId'] as String? ?? '';
    productPrice.value = args['productPrice'] as String? ?? '';
    productName.value = args['productName'] as String? ?? '';
  }

  void selectRating(int rating) {
    selectedRating.value = rating;
    _submitFitRating(rating);
  }

  Future<void> _submitFitRating(int rating) async {
    if (productId.value.isEmpty) return;
    await _reviewsUseCase.requestAddTryOutReview(
      AddTryOutReviewRequest(
        productId: productId.value,
        title: 'tryOnFitRating'.tr,
        comment: 'tryOnFitRatingComment'.tr,
        rating: rating.toDouble(),
      ),
    );
    // Rating is optional feedback; failures are not surfaced to avoid interrupting try-on.
  }

  Future<void> onTryOnAgain() async {
    if (productId.value.isEmpty) return;

    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null) return;

    isLoading.value = true;
    final response = await _productsUseCase.requestTryProduct(
      TryProductRequest(productId: productId.value, imagePath: file.path),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    final url = response.imageUrl;
    if (url != null && url.isNotEmpty) {
      imageUrl.value = url;
    }
  }

  void onAddToCart() {
    Get.rawSnackbar(message: 'addedToCart'.tr);
    Get.toNamed(Routes.cart);
  }

  void onShare() {
    Get.rawSnackbar(message: 'shareComingSoon'.tr);
  }

  void goBack() => Get.back();
}
