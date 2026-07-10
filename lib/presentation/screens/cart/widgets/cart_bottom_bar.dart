import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({
    super.key,
    required this.total,
    required this.isLoading,
    required this.onPayNow,
  });

  final double total;
  final bool isLoading;
  final VoidCallback onPayNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                children: [
                  TextSpan(text: '${'price'.tr}: '),
                  TextSpan(
                    text: '£${total.toStringAsFixed(0)}',
                    style: Get.theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : onPayNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppColors.secondary.withValues(alpha: 0.6),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: AppProgressIndicator(
                          radius: 10,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'payNow'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
