import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ShopAboutSection extends StatelessWidget {
  const ShopAboutSection({
    super.key,
    required this.about,
    required this.isExpanded,
    required this.onReadMore,
  });

  final String about;
  final bool isExpanded;
  final VoidCallback onReadMore;

  @override
  Widget build(BuildContext context) {
    if (about.isEmpty) return const SizedBox.shrink();

    const previewLength = 72;
    final hasMore = about.length > previewLength;
    final displayText =
        isExpanded || !hasMore ? about : '${about.substring(0, previewLength)}...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'aboutStore'.tr,
          style: Get.theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: hasMore && !isExpanded ? onReadMore : null,
          child: Text.rich(
            TextSpan(
              text: displayText,
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
              children: [
                if (hasMore && !isExpanded)
                  TextSpan(
                    text: ' ${'readMore'.tr}',
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
