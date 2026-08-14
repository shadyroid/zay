import 'package:flutter/material.dart';
import 'package:zay/app/utils/app_colors.dart';

class SettingsMenuCard extends StatelessWidget {
  const SettingsMenuCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
