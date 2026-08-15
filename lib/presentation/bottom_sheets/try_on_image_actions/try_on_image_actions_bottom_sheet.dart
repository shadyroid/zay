import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/bottom_sheets/try_on_image_actions/try_on_image_action.dart';

class TryOnImageActionsBottomSheet extends StatelessWidget {
  const TryOnImageActionsBottomSheet({super.key});

  static Future<TryOnImageAction?> show() {
    return Get.bottomSheet<TryOnImageAction>(
      const TryOnImageActionsBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            _ActionItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_share.svg',
                width: 24,
                height: 24,
              ),
              label: 'shareImage'.tr,
              onTap: () => Get.back(result: TryOnImageAction.share),
            ),
            _ActionItem(
              icon: const Icon(
                Icons.download_outlined,
                size: 24,
                color: AppColors.textPrimary,
              ),
              label: 'downloadImage'.tr,
              onTap: () => Get.back(result: TryOnImageAction.download),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Row(
          children: [
            SizedBox(width: 24, height: 24, child: Center(child: icon)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: Get.theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textPrimary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
