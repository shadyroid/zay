import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/widgets/app_text_field.dart';

class ContactUsLabeledField extends StatelessWidget {
  const ContactUsLabeledField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.textInputAction,
    this.inputFormatters,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        AppTextField(
          controller: controller,
          hint: hint,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}
