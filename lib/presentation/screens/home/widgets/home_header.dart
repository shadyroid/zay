import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/widgets/profile_avatar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.imagePath,
    required this.onSearchTap,
    required this.onNotificationsTap,
  });

  final String userName;
  final String? imagePath;
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          ProfileAvatar(size: 48, imagePath: imagePath),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'welcomeBack'.tr,
                  style: Get.theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userName.isNotEmpty ? userName : 'guest'.tr,
                  style: Get.theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onSearchTap,
            icon: SvgPicture.asset(
              'assets/icons/ic_search.svg',
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          IconButton(
            onPressed: onNotificationsTap,
            icon: Badge(
              backgroundColor: Colors.red,
              child: SvgPicture.asset(
                'assets/icons/ic_notifications.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
