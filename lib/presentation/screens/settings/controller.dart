import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/presentation/base/base_controller.dart';
import 'package:hedma/presentation/bottom_sheets/languages/languages_bottom_sheet.dart';

class SettingsController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final displayName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    requestProfile();
  }

  Future<void> requestProfile() async {
    final response = await _authUseCase.requestProfile();
    if (!isSuccess(response)) return;
    displayName.value = response.data?.name ?? '';
  }

  void goBack() {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
      return;
    }
    Get.offNamed(Routes.home);
  }


  void navigateToEditProfile() => Get.toNamed(Routes.editProfile);

  void navigateToFavorite() => Get.toNamed(Routes.favorite);

  void navigateToOrders() => Get.toNamed(Routes.orders);

  void navigateToContactUs() => Get.toNamed(Routes.contactUs);

  void navigateToAboutUs() => Get.toNamed(Routes.aboutUs);

  void navigateToTerms() => Get.toNamed(Routes.terms);

  void navigateToPrivacy() => Get.toNamed(Routes.privacy);

  void onLanguage() {
    final current = PrefsManager.locale ?? Get.locale?.languageCode ?? 'en';
    LanguagesBottomSheet.show(
      selectedCode: current,
      onSelected: _setLocale,
    );
  }

  Future<void> _setLocale(String code) async {
    await PrefsManager.setLocale(code);
    await Get.updateLocale(Locale(code));
  }

  void onShareApp() {
    Get.rawSnackbar(message: 'shareAppComingSoon'.tr);
  }

  Future<void> requestSignOut() async {
    isLoading.value = true;
    final response = await _authUseCase.requestSignOut();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    Get.offAllNamed(Routes.signIn);
  }

  void onClearAccount() {
    Get.dialog(
      AlertDialog(
        title: Text('clearAccount'.tr),
        content: Text('clearAccountConfirm'.tr),
        actions: [
          TextButton(onPressed: Get.back, child: Text('cancel'.tr)),
          TextButton(
            onPressed: () async {
              Get.back();
              await PrefsManager.clear();
              Get.offAllNamed(Routes.signIn);
              Get.rawSnackbar(message: 'clearAccountSuccess'.tr);
            },
            child: Text(
              'clearAccount'.tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
