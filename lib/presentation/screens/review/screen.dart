import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/screens/review/controller.dart';
import 'package:hedma/presentation/screens/review/widgets/product_rating_section.dart';
import 'package:hedma/presentation/screens/review/widgets/review_app_bar.dart';
import 'package:hedma/presentation/screens/review/widgets/review_note_field.dart';
import 'package:hedma/presentation/screens/review/widgets/size_evaluation_section.dart';
import 'package:hedma/presentation/widgets/app_button.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ReviewAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(
                    () => SizeEvaluationSection(
                      selected: controller.selectedSizeFit.value,
                      onSelected: controller.selectSizeFit,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => ProductRatingSection(
                      rating: controller.selectedRating.value,
                      onRatingSelected: controller.selectRating,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ReviewNoteField(controller: controller.reviewController),
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
                  onPressed: controller.requestAddOrderReview,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
