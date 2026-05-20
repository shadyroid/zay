import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';

class ProductDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductDetailsAppBar({
    super.key,
    required this.onBack,
    required this.onShare,
  });

  final VoidCallback onBack;
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
      leading: IconButton(
        icon: SvgPicture.asset(AppIcons.back, width: 20, height: 20),
        onPressed: onBack,
      ),
      title: Text(
        'detailsProduct'.tr,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(AppIcons.share, width: 22, height: 22),
          onPressed: onShare,
        ),
      ],
    );
  }
}
