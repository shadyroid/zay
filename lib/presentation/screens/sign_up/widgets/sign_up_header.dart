import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key, required this.onLogIn});

  final VoidCallback onLogIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'signUp'.tr,
          style: Get.theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'signUpHasAccount'.tr,
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            GestureDetector(
              onTap: onLogIn,
              child: Text(
                'signIn'.tr,
                style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
