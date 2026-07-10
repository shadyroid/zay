import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/screens/review/controller.dart';
import 'package:zay/presentation/screens/review/widgets/order_item_review_card.dart';
import 'package:zay/presentation/screens/review/widgets/review_app_bar.dart';
import 'package:zay/presentation/widgets/app_button.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ReviewAppBar(),
      body: Obx(() {
        if (controller.isLoading.value && controller.itemReviews.isEmpty) {
          return const Center(child: AppProgressIndicator());
        }

        if (controller.itemReviews.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'noItemsToReview'.tr,
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          );
        }

        final drafts = controller.itemReviews;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < drafts.length; i++)
                      OrderItemReviewCard(
                        draft: drafts[i],
                        index: i,
                        total: drafts.length,
                        onSizeFitSelected: (fit) =>
                            controller.selectSizeFit(i, fit),
                        onRatingSelected: (rating) =>
                            controller.selectRating(i, rating),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SafeArea(
                top: false,
                child: Obx(
                  () => AppButton(
                    text: 'submitYourRating'.tr,
                    backgroundColor: AppColors.primary,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.requestAddReview,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
