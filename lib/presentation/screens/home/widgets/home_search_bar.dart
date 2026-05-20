import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.onSearchSubmit,
    required this.onSearchIconTap,
    required this.onCameraTap,
    required this.onFilterTap,
  });

  final TextEditingController controller;
  final VoidCallback onSearchSubmit;
  final VoidCallback onSearchIconTap;
  final VoidCallback onCameraTap;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    constraints: const BoxConstraints(),
                    icon: SvgPicture.asset(
                      AppIcons.search,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: onSearchIconTap,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => onSearchSubmit(),
                      decoration: InputDecoration(
                        hintText: 'searchForProducts'.tr,
                        hintStyle: Theme.of(context)
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    constraints: const BoxConstraints(),
                    icon: SvgPicture.asset(
                      AppIcons.cameraOutline,
                      width: 22,
                      height: 22,
                    ),
                    onPressed: onCameraTap,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: SvgPicture.asset(
                    AppIcons.filter2,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
