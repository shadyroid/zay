import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ProductRatingSection extends StatelessWidget {
  const ProductRatingSection({
    super.key,
    required this.rating,
    required this.onRatingSelected,
  });

  final int rating;
  final ValueChanged<int> onRatingSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'productEvaluation'.tr,
          style: Get.theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'productEvaluationSubtitle'.tr,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(5, (index) {
            final starValue = index + 1;
            final filled = starValue <= rating;
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: InkWell(
                onTap: () => onRatingSelected(starValue),
                borderRadius: BorderRadius.circular(8),
                child: SvgPicture.asset(
                  'assets/icons/ic_star.svg',
                  width: 36,
                  height: 36,
                  colorFilter: ColorFilter.mode(
                    filled ? const Color(0xFFFFC107) : AppColors.border,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
