import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'resetPasswordTitle'.tr,
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'resetPasswordSubtitle'.tr,
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
