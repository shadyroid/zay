import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/domain/models/beans/review_bean.dart';

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
                  review.title.isNotEmpty ? review.title : review.authorName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Text(
                review.createdAt,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ReviewStarRating(rating: review.rating),
          if (review.authorName.isNotEmpty && review.title.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              '${'by'.tr} ${review.authorName}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
            AppIcons.star,
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
