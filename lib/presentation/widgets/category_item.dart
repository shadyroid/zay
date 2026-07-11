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
    final foreground = isSelected ? Colors.white : AppColors.textPrimary;
    final background =
        isSelected ? AppColors.primary : AppColors.screenBackground;

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CategoryIcon(
                  iconUrl: category.icon ?? "",
                  color: foreground,
                ),
                const SizedBox(width: 8),
                Text(
                  category.name ?? "",
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                        color: foreground,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.iconUrl, required this.color});

  final String iconUrl;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (iconUrl.isEmpty) {
      return SvgPicture.asset(
        'assets/icons/ic_category_all.svg',
        width: 18,
        height: 18,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    if (iconUrl.startsWith('assets/')) {
      return SvgPicture.asset(
        iconUrl,
        width: 18,
        height: 18,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    if (!iconUrl.startsWith('http')) {
      return Text(iconUrl, style: const TextStyle(fontSize: 16));
    }

    return Image.network(
      iconUrl,
      width: 18,
      height: 18,
      // colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      // placeholderBuilder: (context) => SizedBox(
      //   width: 18,
      //   height: 18,
      //   child: AppProgressIndicator(radius: 8, color: color),
      // ),
      errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
        'assets/icons/ic_category_all.svg',
        width: 18,
        height: 18,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
