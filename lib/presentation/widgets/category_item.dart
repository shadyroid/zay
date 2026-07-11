import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/category_bean.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryBean category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : Colors.black;

    return IconButton(
      onPressed: onTap,
      icon: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category.name ?? "",
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            if(isSelected)...[
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ]

          ],
        ),
      ),
    );
  }
}
