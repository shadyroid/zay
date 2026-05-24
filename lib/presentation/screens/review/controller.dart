import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/reviews_use_case.dart';
import 'package:hedma/domain/models/enums/review_size_fit.dart';
import 'package:hedma/domain/requests/add_order_review_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ReviewController extends BaseController {
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());

  final reviewController = TextEditingController();
  final selectedSizeFit = ReviewSizeFit.good.obs;
  final selectedRating = 0.obs;

  late final String orderId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    orderId = args['orderId'] as String? ?? '';
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }

  void selectSizeFit(ReviewSizeFit fit) => selectedSizeFit.value = fit;

  void selectRating(int rating) => selectedRating.value = rating;

  Future<void> requestAddOrderReview() async {
    if (orderId.isEmpty) return;
    if (selectedRating.value <= 0) {
      Get.rawSnackbar(message: 'ratingRequired'.tr);
      return;
    }

    isLoading.value = true;
    final response = await _reviewsUseCase.requestAddOrderReview(
      AddOrderReviewRequest(
        orderId: orderId,
        sizeFit: selectedSizeFit.value,
        rating: selectedRating.value.toDouble(),
        comment: reviewController.text.trim(),
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.back();
    Get.rawSnackbar(message: response.message?.tr ?? 'reviewSubmitted'.tr);
  }

  void goBack() => Get.back();
}
