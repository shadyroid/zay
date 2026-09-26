import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/screens/cart/screen.dart';
import 'package:zay/presentation/screens/home/screen.dart';
import 'package:zay/presentation/screens/main/controller.dart';
import 'package:zay/presentation/screens/settings/screen.dart';
import 'package:zay/presentation/screens/shops/screen.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  static const _tabs = [
    _TabData(iconPath: 'assets/icons/ic_nav_home.svg', labelKey: 'home'),
    _TabData(iconPath: 'assets/icons/ic_nav_shops.svg', labelKey: 'shops'),
    _TabData(iconPath: 'assets/icons/ic_nav_cart.svg', labelKey: 'cart'),
    _TabData(iconPath: 'assets/icons/ic_nav_settings.svg', labelKey: 'settings'),
  ];

  static const _pages = <Widget>[
    HomeScreen(),
    ShopsScreen(),
    CartScreen(controllerTag: "main_cart"),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            for (var i = 0; i < _pages.length; i++)
              controller.builtTabs[i] ? _pages[i] : const SizedBox.shrink(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          onTap: controller.onTabSelected,
          items: [
            for (final tab in _tabs)
              BottomNavigationBarItem(
                icon: _NavIcon(iconPath: tab.iconPath),
                label: tab.labelKey.tr,
              ),
          ],
        ),
      ),
    );
  }
}

class _TabData {
  const _TabData({required this.iconPath, required this.labelKey});

  final String iconPath;
  final String labelKey;
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final color = IconTheme.of(context).color;
    return SvgPicture.asset(
      iconPath,
      width: 22,
      height: 22,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
