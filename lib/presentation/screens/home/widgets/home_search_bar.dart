import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/app/utils/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.onSearchSubmit,
    required this.onSearchIconTap,
    required this.onCameraTap,
    this.focusNode,
  });

  final TextEditingController controller;
  final VoidCallback onSearchSubmit;
  final VoidCallback onSearchIconTap;
  final VoidCallback onCameraTap;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            IconButton(
              padding: const EdgeInsetsDirectional.only(start: 8),
              constraints: const BoxConstraints(),
              icon: SvgPicture.asset(
                'assets/icons/ic_search.svg',
                width: 20,
                height: 20,
              ),
              onPressed: onSearchIconTap,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => onSearchSubmit(),
                decoration: InputDecoration(
                  hintText: 'searchForProducts'.tr,
                  hintStyle: Get.theme
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.hint),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 12,
                  ),
                ),
                style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                    ),
              ),
            ),
            IconButton(
              padding: const EdgeInsetsDirectional.only(end: 8),
              constraints: const BoxConstraints(),
              icon: SvgPicture.asset(
                'assets/icons/ic_camera_outline.svg',
                width: 22,
                height: 22,
              ),
              onPressed: onCameraTap,
            ),
          ],
        ),
      ),
    );
  }
}
