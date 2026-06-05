import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/review_bean.dart';
import 'package:hedma/presentation/screens/reviews/widgets/review_item.dart';

class ProductReviewsSection extends StatelessWidget {
  const ProductReviewsSection({
    super.key,
    required this.reviews,
    required this.onSeeAll,
  });

  final List<ReviewBean> reviews;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'productReviews'.tr,
            style: Get.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          ...reviews.take(2).map((review) => ReviewItem(review: review)),
          if (reviews.isNotEmpty) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: onSeeAll,
                child: Text(
                  'seeAllReviews'.tr,
                  style: Get.theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
