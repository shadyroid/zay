import 'package:get/get.dart';
import 'package:hedma/app/use_cases/reviews_use_case.dart';
import 'package:hedma/domain/models/beans/review_bean.dart';
import 'package:hedma/domain/requests/reviews_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ReviewsController extends BaseController {
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());

  final reviews = <ReviewBean>[].obs;

  late final String productId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    productId = args['productId'] as String? ?? '';
    final passed = args['reviews'] as List<ReviewBean>?;
    if (passed != null && passed.isNotEmpty) {
      reviews.assignAll(passed);
    }
    requestReviews();
  }

  Future<void> requestReviews() async {
    if (productId.isEmpty) return;
    isLoading.value = reviews.isEmpty;
    final response = await _reviewsUseCase.requestReviews(
      ReviewsRequest(productId: productId),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    reviews.assignAll(response.data ?? []);
  }

  void goBack() => Get.back();
}
