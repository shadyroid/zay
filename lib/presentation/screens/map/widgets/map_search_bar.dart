import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onTap,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          SvgPicture.asset(
            'assets/icons/ic_search.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.hint,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onTap: onTap,
              onSubmitted: (_) => onSubmitted(),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'searchLocation'.tr,
                hintStyle: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.hint,
                    ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
