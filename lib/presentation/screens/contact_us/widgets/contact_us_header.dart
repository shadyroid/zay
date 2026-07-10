import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ContactUsHeader extends StatelessWidget {
  const ContactUsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/ic_contact_chat.svg',
          width: 80,
          height: 64,
        ),
        const SizedBox(height: 20),
        Text(
          'contactUsHeadline'.tr,
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'contactUsSubtext'.tr,
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
          ),
        ),
      ],
    );
  }
}
