import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class TryOnBottomBar extends StatelessWidget {
  const TryOnBottomBar({
    super.key,
    required this.price,
    required this.onTryOnAgain,
    required this.onAddToCart,
    this.canTryOnAgain = true,
  });

  final double? price;
  final VoidCallback onTryOnAgain;
  final VoidCallback onAddToCart;
  final bool canTryOnAgain;

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
                    text: '£${price?.toStringAsFixed(2)}',
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: canTryOnAgain ? onTryOnAgain : null,
                    icon: SvgPicture.asset(
                      'assets/icons/ic_retry.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        canTryOnAgain
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: Text('tryOnAgain'.tr),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      disabledForegroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.border),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    icon: SvgPicture.asset(
                      'assets/icons/ic_nav_cart.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: Text('addToCart'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
