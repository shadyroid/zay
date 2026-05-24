import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/presentation/screens/settings/controller.dart';
import 'package:hedma/presentation/screens/settings/widgets/delete_account_button.dart';
import 'package:hedma/presentation/screens/settings/widgets/settings_app_bar.dart';
import 'package:hedma/presentation/screens/settings/widgets/settings_menu_card.dart';
import 'package:hedma/presentation/screens/settings/widgets/settings_profile_header.dart';
import 'package:hedma/presentation/screens/settings/widgets/settings_item.dart';
import 'package:hedma/presentation/widgets/main_bottom_nav.dart';

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
          child: Obx(
            () {
              final loggedIn = controller.isLoggedIn.value;

              return Column(
                children: [
                  if (loggedIn) ...[
                    SettingsProfileHeader(name: controller.displayName.value),
                    const SizedBox(height: 24),
                  ],
                  SettingsMenuCard(
                    children: [
                      if (loggedIn) ...[
                        SettingsItem(
                          iconPath: AppIcons.editProfile,
                          title: 'editProfile'.tr,
                          onTap: controller.navigateToEditProfile,
                        ),
                        SettingsItem(
                          iconPath: AppIcons.lock,
                          title: 'changePassword'.tr,
                          onTap: controller.navigateToChangePassword,
                        ),
                        SettingsItem(
                          iconPath: AppIcons.favorite,
                          title: 'favorite'.tr,
                          onTap: controller.navigateToFavorite,
                        ),
                        SettingsItem(
                          iconPath: AppIcons.orders,
                          title: 'myOrders'.tr,
                          onTap: controller.navigateToOrders,
                        ),
                      ],
                      SettingsItem(
                        iconPath: AppIcons.connectUs,
                        title: 'contactUs'.tr,
                        onTap: controller.navigateToContactUs,
                      ),
                      SettingsItem(
                        iconPath: AppIcons.language,
                        title: 'language'.tr,
                        onTap: controller.onLanguage,
                      ),
                      SettingsItem(
                        iconPath: AppIcons.aboutUs,
                        title: 'aboutUs'.tr,
                        onTap: controller.navigateToAboutUs,
                      ),
                      SettingsItem(
                        iconPath: AppIcons.terms,
                        title: 'terms'.tr,
                        onTap: controller.navigateToTerms,
                      ),
                      SettingsItem(
                        iconPath: AppIcons.privacy,
                        title: 'privacy'.tr,
                        onTap: controller.navigateToPrivacy,
                      ),
                      SettingsItem(
                        iconPath: AppIcons.share,
                        title: 'shareApp'.tr,
                        onTap: controller.onShareApp,
                      ),
                      SettingsItem(
                        iconPath: loggedIn ? AppIcons.signOut : AppIcons.signIn,
                        title: loggedIn ? 'signOut'.tr : 'signIn'.tr,
                        onTap: loggedIn
                            ? controller.requestSignOut
                            : controller.navigateToSignIn,
                        showDivider: false,
                      ),
                    ],
                  ),
                  if (loggedIn) ...[
                    const SizedBox(height: 24),
                    DeleteAccountButton(onPressed: controller.onDeleteAccount),
                  ],
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 3),
    );
  }
}
