import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/widgets/profile_avatar.dart';

class ProfileAvatarHeader extends StatelessWidget {
  const ProfileAvatarHeader({
    super.key,
    required this.name,
    required this.onEditPhoto,
    this.imagePath,
  });

  final String name;
  final VoidCallback onEditPhoto;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onEditPhoto,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ProfileAvatar(size: 100, imagePath: imagePath),
              PositionedDirectional(
                end: 0,
                bottom: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/ic_camera.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name.isEmpty ? 'fullName'.tr : name,
          style: Get.theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
