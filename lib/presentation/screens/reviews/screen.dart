import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/reviews/controller.dart';
import 'package:hedma/presentation/screens/reviews/widgets/review_item.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';
import 'package:hedma/presentation/widgets/empty_state.dart';

class ReviewsScreen extends GetView<ReviewsController> {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'productReviews'.tr,
        showDivider: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.reviews.isEmpty) {
          return const Center(child: AppProgressIndicator());
        }

        if (controller.reviews.isEmpty) {
          return EmptyState(
            message: 'emptyReviews'.tr,
            icon: Icons.rate_review_outlined,
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          itemCount: controller.reviews.length,
          separatorBuilder: (context, _) => const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEEEEEE),
          ),
          itemBuilder: (context, index) {
            return ReviewItem(review: controller.reviews[index]);
          },
        );
      }),
    );
  }
}
