import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/utils/app_auth_guard.dart';
import 'package:hedma/app/utils/app_colors.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  static const _items = [
    _NavItemData(
      iconPath: 'assets/icons/ic_nav_home.svg',
      labelKey: 'home',
      route: Routes.home,
    ),
    _NavItemData(
      iconPath: 'assets/icons/ic_nav_shops.svg',
      labelKey: 'shops',
      route: Routes.shops,
    ),
    _NavItemData(
      iconPath: 'assets/icons/ic_nav_cart.svg',
      labelKey: 'cart',
      route: Routes.cart,
      requiresAuth: true,
    ),
    _NavItemData(
      iconPath: 'assets/icons/ic_nav_settings.svg',
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
                  onTap: () => _onNavTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onNavTap(int index) async {
    if (index == currentIndex) return;
    final item = _items[index];
    if (item.requiresAuth) {
      await AppAuthGuard.offNamed(item.route);
      return;
    }
    Get.offNamed(item.route);
  }
}

class _NavItemData {
  const _NavItemData({
    required this.iconPath,
    required this.labelKey,
    required this.route,
    this.requiresAuth = false,
  });

  final String iconPath;
  final String labelKey;
  final String route;
  final bool requiresAuth;
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
              style: Get.theme.textTheme.labelSmall?.copyWith(
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
