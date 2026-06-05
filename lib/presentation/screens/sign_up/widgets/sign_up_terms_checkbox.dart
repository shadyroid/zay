import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';

class SignUpTermsCheckbox extends StatelessWidget {
  const SignUpTermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onTermsTap,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTermsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            side: const BorderSide(color: AppColors.border, width: 1.5),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text.rich(
              TextSpan(
                text: 'signUpTermsPrefix'.tr,
                style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                children: [
                  TextSpan(
                    text: 'signUpTermsLink'.tr,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
