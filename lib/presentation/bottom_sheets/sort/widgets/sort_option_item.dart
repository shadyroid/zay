import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/product_sort_option.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            option.labelKey.tr,
            style: Get.theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}
