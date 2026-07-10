import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ReviewNoteField extends StatelessWidget {
  const ReviewNoteField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      style: Get.theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
      decoration: InputDecoration(
        hintText: 'writeReviewOptional'.tr,
        hintStyle: Get.theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.hint,
            ),
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
          child: SvgPicture.asset(
            'assets/icons/ic_edit_profile.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.hint,
              BlendMode.srcIn,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
