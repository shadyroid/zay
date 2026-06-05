import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/widgets/profile_avatar.dart';

class SettingsProfileHeader extends StatelessWidget {
  const SettingsProfileHeader({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileAvatar(size: 88),
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
