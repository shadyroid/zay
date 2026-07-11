import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class VerificationTimerRow extends StatelessWidget {
  const VerificationTimerRow({
    super.key,
    required this.timerText,
    required this.canResend,
    required this.onResend,
  });

  final String timerText;
  final bool canResend;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_timer.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              timerText,
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: canResend ? onResend : null,
          child: Text(
            'resendCode'.tr,
            style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: canResend
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: canResend ? FontWeight.w600 : FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }
}
