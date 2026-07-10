import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class FilterSectionTitle extends StatelessWidget {
  const FilterSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
      child: Text(
        title,
        style: Get.theme.textTheme.titleSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
