import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class TryOnFeedbackSection extends StatelessWidget {
  const TryOnFeedbackSection({
    super.key,
    required this.selectedRating,
    required this.onRatingSelected,
  });

  final int selectedRating;
  final ValueChanged<int> onRatingSelected;

  static const _starColor = Color(0xFFFFC107);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'yourOpinionMatters'.tr,
            style: Get.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'howWellDoesItFit'.tr,
            style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              final filled = starIndex <= selectedRating;
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: GestureDetector(
                  onTap: () => onRatingSelected(starIndex),
                  child: SvgPicture.asset(
                    'assets/icons/ic_star.svg',
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(
                      filled ? _starColor : AppColors.border,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
