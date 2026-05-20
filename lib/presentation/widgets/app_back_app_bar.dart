import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';

class AppBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackAppBar({
    super.key,
    required this.onBack,
    this.title,
    this.showDivider = false,
  });

  final VoidCallback onBack;
  final String? title;
  final bool showDivider;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (showDivider ? 1 : 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textPrimary,
          size: 20,
        ),
        onPressed: onBack,
      ),
      title: title == null
          ? null
          : Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
      bottom: showDivider
          ? const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.border,
              ),
            )
          : null,
    );
  }
}
