import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/notification_bean.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    this.onTap,
  });

  final NotificationBean notification;
  final VoidCallback? onTap;

  static const double _avatarSize = 48;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.screenBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? '',
                    style: Get.theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.body ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsetsDirectional.only(start: 8, top: 4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final imageUrl = notification.imageUrl;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return AppImage.network(
        imageUrl,
        width: _avatarSize,
        height: _avatarSize,
        shape: AppImageShape.circle,
        errorWidget: _logoAvatar(),
      );
    }

    return _logoAvatar();
  }

  Widget _logoAvatar() {
    return Container(
      width: _avatarSize,
      height: _avatarSize,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/icons/ic_logo.svg',
        width: 26,
        height: 26,
      ),
    );
  }
}
