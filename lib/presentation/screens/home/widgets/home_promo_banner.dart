import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';

class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({
    super.key,
    required this.onVirtualTryOn,
    required this.onSearchByImage,
  });

  final VoidCallback onVirtualTryOn;
  final VoidCallback onSearchByImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5E8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _PromoTile(
                  iconPath: AppIcons.person,
                  title: 'virtualTryOn'.tr,
                  subtitle: 'virtualTryOnSubtitle'.tr,
                  onTap: onVirtualTryOn,
                ),
              ),
              Container(width: 1, color: AppColors.border.withValues(alpha: 0.5)),
              Expanded(
                child: _PromoTile(
                  iconPath: AppIcons.cameraOutline,
                  title: 'searchByImage'.tr,
                  subtitle: 'searchByImageSubtitle'.tr,
                  onTap: onSearchByImage,
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
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                AppColors.secondary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
