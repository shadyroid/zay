import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class TryOnAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TryOnAppBar({
    super.key,
    required this.onShare,
  });

  final VoidCallback onShare;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        'virtualTryOn'.tr,
        style: Get.theme.textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset('assets/icons/ic_share.svg', width: 22, height: 22),
          onPressed: onShare,
        ),
      ],
    );
  }
}
