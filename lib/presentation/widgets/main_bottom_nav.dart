import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        if (index == currentIndex) return;
        switch (index) {
          case 0:
            Get.offNamed(Routes.home);
          case 1:
            Get.offNamed(Routes.shops);
          case 2:
            Get.offNamed(Routes.cart);
          case 3:
            Get.offNamed(Routes.settings);
        }
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: 'home'.tr,
        ),
        NavigationDestination(
          icon: const Icon(Icons.store_outlined),
          selectedIcon: const Icon(Icons.store),
          label: 'shops'.tr,
        ),
        NavigationDestination(
          icon: const Icon(Icons.shopping_cart_outlined),
          selectedIcon: const Icon(Icons.shopping_cart),
          label: 'cart'.tr,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: 'settings'.tr,
        ),
      ],
    );
  }
}
