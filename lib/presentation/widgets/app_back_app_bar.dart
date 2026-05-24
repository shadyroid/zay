import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';

class AppBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackAppBar({
    super.key,
    this.title,
    this.showDivider = false,
    this.actions,
  });

  final String? title;
  final bool showDivider;
  final List<Widget>? actions;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (showDivider ? 1 : 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: AppColors.textPrimary,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      centerTitle: true,
      title: title == null
          ? null
          : Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
      actions: actions,
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
