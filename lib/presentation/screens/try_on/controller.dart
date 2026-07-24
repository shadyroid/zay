import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/products_use_case.dart';
import 'package:zay/app/use_cases/reviews_use_case.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/app/utils/image_picker_helper.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/domain/models/requests/try_on_request.dart';
import 'package:zay/domain/models/requests/try_on_review_request.dart';
import 'package:zay/presentation/base/base_controller.dart';
import 'package:image_picker/image_picker.dart';

class TryOnController extends BaseController {
  final ProductsUseCase _productsUseCase = Get.put(ProductsUseCase());
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());

  late XFile file;
  final imageUrl = RxnString();
  int? tryOnId;
  late ProductBean product;
  final selectedRating = 1.obs;

  @override
  void onInit() {
    super.onInit();
    file = Get.arguments['file'];
    product = Get.arguments['product'];
    requestTryOn();
  }

  void selectRating(int rating) {
    selectedRating.value = rating;
    _submitFitRating(rating);
  }

  Future<void> _submitFitRating(int rating) async {
    await _reviewsUseCase.requestTryOnReview(TryOnReviewRequest(tryOnId: tryOnId, rate: rating));
  }

  Future<void> onTryOnAgain() async {
    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null) return;
    requestTryOn();
  }

  Future<void> requestTryOn() async {
    isLoading.value = true;
    final response = await _productsUseCase.requestTryOn(
      TryOnRequest(productId: product.id, image: file),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    tryOnId = response.id;
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
