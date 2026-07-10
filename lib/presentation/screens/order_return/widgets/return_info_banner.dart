import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ReturnInfoBanner extends StatelessWidget {
  const ReturnInfoBanner({super.key, this.message});

  final String? message;

  static const Color _background = Color(0xFFE8F6EF);

  @override
  Widget build(BuildContext context) {
    final text = message?.trim();
    if (text == null || text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 22,
            color: AppColors.orderSuccess,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Get.theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.orderSuccess,
                    height: 1.45,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
