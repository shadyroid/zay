import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ProductDetailsBottomBar extends StatelessWidget {
  const ProductDetailsBottomBar({
    super.key,
    required this.price,
    required this.isTryOnLoading,
    required this.onTryOn,
    required this.onAddToCart,
  });

  final double? price;
  final bool isTryOnLoading;
  final VoidCallback onTryOn;
  final VoidCallback onAddToCart;

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
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: RichText(
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
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onTryOn,
                    icon: isTryOnLoading?CupertinoActivityIndicator():SvgPicture.asset(
                      'assets/icons/ic_person_2.svg',
                      width: 20,
                      height: 20,
                    ),
                    label: Text('tryOn'.tr),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.textPrimary),
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
