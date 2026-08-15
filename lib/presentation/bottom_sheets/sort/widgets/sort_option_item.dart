import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/domain/models/enums/product_sort_option.dart';

class SortOptionItem extends StatelessWidget {
  const SortOptionItem({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final ProductSortOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.fast,
        curve: AppMotion.standard,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.06)
            : Colors.transparent,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: AnimatedDefaultTextStyle(
            duration: AppMotion.fast,
            curve: AppMotion.standard,
            style: (Get.theme.textTheme.bodyLarge ?? const TextStyle()).copyWith(
              color: AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            ),
            child: Text(option.labelKey.tr),
          ),
        ),
      ),
    );
  }
}
