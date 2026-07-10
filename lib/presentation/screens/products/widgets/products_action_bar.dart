import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ProductsActionBar extends StatelessWidget {
  const ProductsActionBar({
    super.key,
    required this.onFilters,
    required this.onSort,
  });

  final VoidCallback onFilters;
  final VoidCallback onSort;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _ActionButton(
                iconPath: 'assets/icons/ic_filter.svg',
                label: 'filters'.tr,
                onTap: onFilters,
              ),
            ),
            const VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppColors.border,
            ),
            Expanded(
              child: _ActionButton(
                iconPath: 'assets/icons/ic_sort.svg',
                label: 'sortBy'.tr,
                onTap: onSort,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
