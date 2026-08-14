import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.showDivider = true,
    this.animationIndex,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;
  final int? animationIndex;

  @override
  Widget build(BuildContext context) {
    Widget tile = Column(
      children: [
        Material(
          type: MaterialType.transparency,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leading: SvgPicture.asset(
              iconPath,
              width: 22,
              height: 22,
            ),
            title: Text(
              title,
              style: Get.theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: AppColors.textSecondary,
            ),
            onTap: onTap,
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: AppColors.border,
          ),
      ],
    );

    if (animationIndex != null) {
      tile = tile.animateStagger(animationIndex!);
    }
    return tile;
  }
}
