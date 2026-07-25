import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';

class FavoriteEmptyState extends StatelessWidget {
  const FavoriteEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_favorite.svg',
              width: 64,
              height: 64,
              colorFilter: const ColorFilter.mode(
                AppColors.hint,
                BlendMode.srcIn,
              ),
            ).animateScaleIn(begin: 0.8),
            const SizedBox(height: 16),
            Text(
              'emptyFavorites'.tr,
              textAlign: TextAlign.center,
              style: Get.theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ).animateEntrance(delay: const Duration(milliseconds: 80)),
          ],
        ),
      ),
    );
  }
}
