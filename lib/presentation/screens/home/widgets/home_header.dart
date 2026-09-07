import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/widgets/profile_avatar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.imagePath,
    required this.unreadNotificationsCount,
    required this.onSearchTap,
    required this.onNotificationsTap,
  });

  final String userName;
  final String? imagePath;
  final int unreadNotificationsCount;
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
          IntroStepBuilder(
            group: 'searchByImage',
            order: 1,
            padding: const EdgeInsets.all(4),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            text:
                '${'searchImageGuideSearchTitle'.tr}\n${'searchImageGuideSearchDesc'.tr}',
            builder: (context, key) => IconButton(
              key: key,
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
          ),
          IconButton(
            onPressed: onNotificationsTap,
            icon: Badge(
              isLabelVisible: unreadNotificationsCount > 0,
              backgroundColor: Colors.red,
              label: Text(
                unreadNotificationsCount > 99
                    ? '99+'
                    : '$unreadNotificationsCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
