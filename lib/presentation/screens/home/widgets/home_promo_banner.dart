import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';

class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({super.key});

  static const Color _bannerBackground = Color(0xFFFDF6F0);
  static const Color _iconBackground = Color(0xFFFCEEE4);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: _bannerBackground,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _PromoTile(
                  iconPath: 'assets/icons/ic_virtual_try_on.svg',
                  title: 'virtualTryOn'.tr,
                  subtitle: 'virtualTryOnSubtitle'.tr,
                ),
              ),
              Container(
                width: 1,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: AppColors.border.withValues(alpha: 0.6),
              ),
              Expanded(
                child: _PromoTile(
                  iconPath: 'assets/icons/ic_search_by_image.svg',
                  title: 'searchByImage'.tr,
                  subtitle: 'searchByImageSubtitle'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoTile extends StatelessWidget {
  const _PromoTile({
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  final String iconPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: HomePromoBanner._iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Get.theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
