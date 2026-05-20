import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  static const _items = [
    _NavItemData(
      iconPath: AppIcons.navHome,
      labelKey: 'home',
      route: Routes.home,
    ),
    _NavItemData(
      iconPath: AppIcons.navShops,
      labelKey: 'shops',
      route: Routes.shops,
    ),
    _NavItemData(
      iconPath: AppIcons.navCart,
      labelKey: 'cart',
      route: Routes.cart,
    ),
    _NavItemData(
      iconPath: AppIcons.navSettings,
      labelKey: 'settings',
      route: Routes.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: List.generate(
              _items.length,
              (index) => Expanded(
                child: _BottomNavItem(
                  iconPath: _items[index].iconPath,
                  label: _items[index].labelKey.tr,
                  isSelected: currentIndex == index,
                  onTap: () {
                    if (index == currentIndex) return;
                    Get.offNamed(_items[index].route);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.iconPath,
    required this.labelKey,
    required this.route,
  });

  final String iconPath;
  final String labelKey;
  final String route;
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.secondary : AppColors.textSecondary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
