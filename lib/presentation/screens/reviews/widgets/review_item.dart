import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/review_bean.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review});

  final ReviewBean review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  review.title??"",
                  style: Get.theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Text(
                review.createdAt??"",
                style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ReviewStarRating(rating: review.rating??0.0),
          if (review.authorName?.isNotEmpty==true) ...[
            const SizedBox(height: 4),
            Text(
              '${'by'.tr} ${review.authorName}',
              style: Get.theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          if (review.comment?.isNotEmpty == true ) ...[
            const SizedBox(height: 8),
            Text(
              review.comment??"",
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class ReviewStarRating extends StatelessWidget {
  const ReviewStarRating({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final filled = index < rating.round();
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 2),
          child: SvgPicture.asset(
            'assets/icons/ic_star.svg',
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(
              filled ? const Color(0xFFFFC107) : AppColors.border,
              BlendMode.srcIn,
            ),
          ),
        );
      }),
    );
  }
}
