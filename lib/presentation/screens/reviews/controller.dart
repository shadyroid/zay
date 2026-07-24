import 'package:get/get.dart';
import 'package:zay/app/use_cases/reviews_use_case.dart';
import 'package:zay/domain/models/beans/review_bean.dart';
import 'package:zay/domain/models/requests/reviews_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class ReviewsController extends BaseController {
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());

  final reviews = <ReviewBean>[].obs;

  late final int productId;

  @override
  void onInit() {
    super.onInit();
    productId =  Get.arguments['productId'];
    final passed = Get.arguments['reviews'];
    if (passed != null && passed.isNotEmpty) {
      reviews.assignAll(passed);
    }
    requestReviews();
  }

  Future<void> requestReviews() async {
    isLoading.value = reviews.isEmpty;
    final response = await _reviewsUseCase.requestReviews(
      ReviewsRequest(productId: productId),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;
    reviews.assignAll(response.data ?? []);
  }

  
}
