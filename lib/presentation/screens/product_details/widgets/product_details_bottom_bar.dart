import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ProductDetailsBottomBar extends StatelessWidget {
  const ProductDetailsBottomBar({
    super.key,
    required this.price,
    required this.isTryOnEnabled,
    required this.isTryOnLoading,
    required this.isOutOfStock,
    required this.onTryOn,
    required this.onAddToCart,
    this.showTryOnIntro = false,
    this.onTryOnIntroReady,
  });

  final double? price;
  final bool? isTryOnEnabled;
  final bool isTryOnLoading;
  final bool isOutOfStock;
  final VoidCallback onTryOn;
  final VoidCallback onAddToCart;
  final bool showTryOnIntro;
  final ValueChanged<BuildContext>? onTryOnIntroReady;

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
                if (isTryOnEnabled == true) ...[
                  Expanded(child: _tryOnButton(context)),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isOutOfStock ? null : onAddToCart,
                    icon: SvgPicture.asset(
                      'assets/icons/ic_nav_cart.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        isOutOfStock ? AppColors.textSecondary : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: Text(
                      isOutOfStock ? 'outOfStock'.tr : 'addToCart'.tr,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.border,
                      disabledForegroundColor: AppColors.textSecondary,
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

  Widget _tryOnButton(BuildContext context) {
    final button = OutlinedButton.icon(
      onPressed: onTryOn,
      icon: isTryOnLoading
          ? const CupertinoActivityIndicator()
          : SvgPicture.asset(
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
    );

    if (!showTryOnIntro) return button;

    return IntroStepBuilder(
      group: 'tryOnButton',
      order: 2,
      padding: EdgeInsets.zero,
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      text: '${'tryOnGuideButtonTitle'.tr}\n${'tryOnGuideButtonDesc'.tr}',
      onWidgetLoad: onTryOnIntroReady == null
          ? null
          : () => onTryOnIntroReady!(context),
      builder: (context, key) => KeyedSubtree(key: key, child: button),
    );
  }
}
