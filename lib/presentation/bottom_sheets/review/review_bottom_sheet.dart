import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/order_product_bean.dart';
import 'package:zay/presentation/bottom_sheets/review/review_bottom_sheet_controller.dart';
import 'package:zay/presentation/screens/review/widgets/order_item_review_card.dart';
import 'package:zay/presentation/widgets/app_button.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class ReviewBottomSheet extends GetView<ReviewBottomSheetController> {
  const ReviewBottomSheet({super.key});

  static Future<void> show({
    required int orderId,
    required OrderProductBean item,
  }) async {
    Get.put(
      ReviewBottomSheetController(
        orderId: orderId,
        item: item,
      ),
    );
    try {
      await Get.bottomSheet(
        const ReviewBottomSheet(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } finally {
      if (Get.isRegistered<ReviewBottomSheetController>()) {
        Get.delete<ReviewBottomSheetController>();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.88;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        height: sheetHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.close),
                      color: AppColors.textSecondary,
                    ),
                    Expanded(
                      child: Text(
                        'yourOpinionMatters'.tr,
                        textAlign: TextAlign.center,
                        style: Get.theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Text(
                  'howWellDoesItFit'.tr,
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.itemReviews.isEmpty) {
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
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: drafts.length,
                    itemBuilder: (context, index) {
                      return OrderItemReviewCard(
                        draft: drafts[index],
                        index: index,
                        total: drafts.length,
                        onSizeFitSelected: (fit) =>
                            controller.selectSizeFit(index, fit),
                        onRatingSelected: (rating) =>
                            controller.selectRating(index, rating),
                      );
                    },
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Obx(
                  () => AppButton(
                    text: 'submitYourRating'.tr,
                    backgroundColor: AppColors.primary,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.itemReviews.isEmpty
                        ? null
                        : controller.requestAddReview,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextButton(
                  onPressed: Get.back,
                  child: Text(
                    'maybeLater'.tr,
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
