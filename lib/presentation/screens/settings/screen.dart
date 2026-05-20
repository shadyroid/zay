import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/settings/controller.dart';
import 'package:hedma/presentation/screens/settings/widgets/settings_tile.dart';
import 'package:hedma/presentation/widgets/main_bottom_nav.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SettingsTile(
            icon: Icons.person_outline,
            title: 'editProfile'.tr,
            onTap: controller.navigateToEditProfile,
          ),
          SettingsTile(
            icon: Icons.favorite_outline,
            title: 'favorite'.tr,
            onTap: controller.navigateToFavorite,
          ),
          SettingsTile(
            icon: Icons.receipt_long_outlined,
            title: 'orders'.tr,
            onTap: controller.navigateToOrders,
          ),
          SettingsTile(
            icon: Icons.mail_outline,
            title: 'contactUs'.tr,
            onTap: controller.navigateToContactUs,
          ),
          SettingsTile(
            icon: Icons.info_outline,
            title: 'aboutUs'.tr,
            onTap: controller.navigateToAboutUs,
          ),
          SettingsTile(
            icon: Icons.description_outlined,
            title: 'terms'.tr,
            onTap: controller.navigateToTerms,
          ),
          SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'privacy'.tr,
            onTap: controller.navigateToPrivacy,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text('logout'.tr, style: const TextStyle(color: Colors.red)),
            onTap: controller.requestLogout,
          ),
        ],
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 3),
    );
  }
}
