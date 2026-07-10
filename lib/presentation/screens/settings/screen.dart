import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/screens/settings/controller.dart';
import 'package:zay/presentation/screens/settings/widgets/settings_app_bar.dart';
import 'package:zay/presentation/screens/settings/widgets/settings_item.dart';
import 'package:zay/presentation/screens/settings/widgets/settings_menu_card.dart';
import 'package:zay/presentation/screens/settings/widgets/settings_profile_header.dart';
import 'package:zay/presentation/widgets/main_bottom_nav.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SettingsAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.screenBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: Obx(() {
            final loggedIn = controller.isLoggedIn.value;

            return Column(
              children: [
                if (loggedIn) ...[
                  SettingsProfileHeader(
                    name: controller.displayName.value,
                    imagePath: controller.profileImagePath.value,
                  ),
                  const SizedBox(height: 24),
                ],
                SettingsMenuCard(
                  children: [
                    if (loggedIn) ...[
                      SettingsItem(
                        iconPath: 'assets/icons/ic_edit_profile.svg',
                        title: 'editProfile'.tr,
                        onTap: controller.navigateToEditProfile,
                      ),
                      SettingsItem(
                        iconPath: 'assets/icons/ic_lock.svg',
                        title: 'changePassword'.tr,
                        onTap: controller.navigateToChangePassword,
                      ),
                      SettingsItem(
                        iconPath: 'assets/icons/ic_favorite.svg',
                        title: 'favorite'.tr,
                        onTap: controller.navigateToFavorite,
                      ),
                      SettingsItem(
                        iconPath: 'assets/icons/ic_orders.svg',
                        title: 'myOrders'.tr,
                        onTap: controller.navigateToOrders,
                      ),
                    ],
                    SettingsItem(
                      iconPath: 'assets/icons/ic_connect_us.svg',
                      title: 'contactUs'.tr,
                      onTap: controller.navigateToContactUs,
                    ),
                    SettingsItem(
                      iconPath: 'assets/icons/ic_language.svg',
                      title: 'language'.tr,
                      onTap: controller.onLanguage,
                    ),
                    SettingsItem(
                      iconPath: 'assets/icons/ic_about_us.svg',
                      title: 'aboutUs'.tr,
                      onTap: controller.navigateToAboutUs,
                    ),
                    SettingsItem(
                      iconPath: 'assets/icons/ic_terms.svg',
                      title: 'terms'.tr,
                      onTap: controller.navigateToTerms,
                    ),
                    SettingsItem(
                      iconPath: 'assets/icons/ic_privacy.svg',
                      title: 'privacy'.tr,
                      onTap: controller.navigateToPrivacy,
                    ),
                    SettingsItem(
                      iconPath: 'assets/icons/ic_share.svg',
                      title: 'shareApp'.tr,
                      onTap: controller.onShareApp,
                    ),
                    SettingsItem(
                      iconPath: loggedIn
                          ? 'assets/icons/ic_sign_out.svg'
                          : 'assets/icons/ic_sign_in.svg',
                      title: loggedIn ? 'signOut'.tr : 'signIn'.tr,
                      onTap: loggedIn
                          ? controller.requestSignOut
                          : controller.navigateToSignIn,
                      showDivider: false,
                    ),
                  ],
                ),
                // if (loggedIn) ...[
                //   const SizedBox(height: 24),
                //   DeleteAccountButton(onPressed: controller.onDeleteAccount),
                // ],
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 3),
    );
  }
}
