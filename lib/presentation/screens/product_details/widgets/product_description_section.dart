import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';

class ProductDescriptionSection extends StatelessWidget {
  const ProductDescriptionSection({
    super.key,
    required this.description,
    required this.isExpanded,
    required this.onToggle,
  });

  final String description;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    if (description.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isExpanded || description.length < 120
                ? description
                : '${description.substring(0, 120)}...',
            style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
          if (description.length >= 120)
            GestureDetector(
              onTap: onToggle,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  isExpanded ? 'readLess'.tr : 'readMore'.tr,
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
