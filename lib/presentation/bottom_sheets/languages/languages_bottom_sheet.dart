import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/app/utils/app_languages.dart';
import 'package:hedma/presentation/bottom_sheets/languages/widgets/language_item.dart';

class LanguagesBottomSheet extends StatelessWidget {
  const LanguagesBottomSheet({
    super.key,
    required this.selectedCode,
    required this.onSelected,
  });

  final String selectedCode;
  final ValueChanged<String> onSelected;

  static Future<void> show({
    required String selectedCode,
    required ValueChanged<String> onSelected,
  }) {
    return Get.bottomSheet(
      LanguagesBottomSheet(
        selectedCode: selectedCode,
        onSelected: onSelected,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.sheetHeaderBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'chooseLanguage'.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: SvgPicture.asset(
                      AppIcons.close,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: Get.back,
                  ),
                ],
              ),
            ),
            ...AppLanguages.options.map(
              (language) => LanguageItem(
                language: language,
                isSelected: language.code == selectedCode,
                onTap: () {
                  onSelected(language.code);
                  Get.back();
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
