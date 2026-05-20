import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/app/utils/app_languages.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final AppLanguageOption language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                language.flagUrl,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 32,
                  height: 32,
                  color: AppColors.border,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                language.labelKey.tr,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textPrimary,
                    ),
              ),
            ),
            if (isSelected)
              SvgPicture.asset(
                AppIcons.check,
                width: 22,
                height: 22,
              ),
          ],
        ),
      ),
    );
  }
}
