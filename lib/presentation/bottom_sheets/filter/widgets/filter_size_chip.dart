import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/domain/models/beans/size_bean.dart';

class FilterSizeChip extends StatelessWidget {
  const FilterSizeChip({
    super.key,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  final SizeBean size;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected ? Colors.white : AppColors.textPrimary;
    final background =
        isSelected ? AppColors.primary : AppColors.screenBackground;

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedScale(
            scale: isSelected ? 1.06 : 1.0,
            duration: AppMotion.fast,
            curve: AppMotion.standard,
            child: AnimatedContainer(
              duration: AppMotion.fast,
              curve: AppMotion.standard,
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: AppMotion.fast,
                  style: (Get.theme.textTheme.titleSmall ?? const TextStyle())
                      .copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Text(size.label ?? ""),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
