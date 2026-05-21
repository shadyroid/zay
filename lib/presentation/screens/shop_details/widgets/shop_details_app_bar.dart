import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';

class ShopDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopDetailsAppBar({
    super.key,
    required this.title,
    required this.onShare,
  });

  final String title;
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
        title,
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
