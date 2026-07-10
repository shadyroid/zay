import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
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
        isSelected ? AppColors.secondary : AppColors.screenBackground;

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10),
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 48,
            height: 48,
            child: Center(
              child: Text(
                size.label ?? "",
                style: Get.theme.textTheme.titleSmall?.copyWith(
                      color: foreground,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
