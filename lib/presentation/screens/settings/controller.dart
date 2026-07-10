import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/auth_use_case.dart';
import 'package:zay/app/use_cases/settings_use_case.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/presentation/base/base_controller.dart';
import 'package:zay/presentation/bottom_sheets/languages/languages_bottom_sheet.dart';
import 'package:zay/presentation/widgets/app_alert_dialog.dart';
import 'package:share_plus/share_plus.dart';

class SettingsController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());
  final SettingsUseCase _settingsUseCase = Get.put(SettingsUseCase());

  final displayName = ''.obs;
  final profileImagePath = RxnString();
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    refreshAuthState();
  }

  @override
  void onReady() {
    super.onReady();
    refreshAuthState();
  }

  void refreshAuthState() {
    isLoggedIn.value = PrefsManager.isLoggedIn;
    if (isLoggedIn.value) {
      requestProfile();
    } else {
      displayName.value = '';
    }
  }

  Future<void> requestProfile() async {
    final response = await _authUseCase.requestProfile();
    if (!isSuccess(response)) return;
    displayName.value = response.data?.name ?? '';
    profileImagePath.value = response.data?.avatarUrl;
  }

  void goBack() {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
      return;
    }
    Get.offNamed(Routes.home);
  }

  Future<void> navigateToEditProfile() async {
    await Get.toNamed(Routes.editProfile);
    requestProfile();
  }

  void navigateToChangePassword() => Get.toNamed(Routes.changePassword);

  Future<void> navigateToFavorite() async {
    Get.toNamed(Routes.favorite);
  }

  Future<void> navigateToOrders() async {
    Get.toNamed(Routes.orders);
  }

  void navigateToSignIn() => Get.toNamed(Routes.signIn);

  void navigateToContactUs() => Get.toNamed(Routes.contactUs);

  void navigateToAboutUs() => Get.toNamed(Routes.aboutUs);

  void navigateToTerms() => Get.toNamed(Routes.terms);

  void navigateToPrivacy() => Get.toNamed(Routes.privacy);

  void onLanguage() {
    final current =
        _settingsUseCase.getLocale() ?? Get.locale?.languageCode ?? 'en';
    LanguagesBottomSheet.show(selectedCode: current, onSelected: _setLocale);
  }

  Future<void> _setLocale(String code) async {
    await _settingsUseCase.requestSetLocale(code);
    await Get.updateLocale(Locale(code));
  }

  Future<void> onShareApp() async {
    await SharePlus.instance.share(
      ShareParams(
        text: 'shareAppMessage'.trParams({
          'appName': Constants.appName,
          'androidUrl': Constants.androidStoreUrl,
          'iosUrl': Constants.iosStoreUrl,
        }),
        subject: 'shareAppSubject'.tr,
      ),
    );
  }

  Future<void> requestSignOut() async {
    isLoading.value = true;
    final response = await _authUseCase.requestSignOut();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    Get.offAllNamed(Routes.signIn);
  }

  Future<void> requestDeleteAccount() async {
    isLoading.value = true;
    final response = await _authUseCase.requestDeleteAccount();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    Get.offAllNamed(Routes.signIn);
    Get.rawSnackbar(message: response.message?.tr ?? 'deleteAccountSuccess'.tr);
  }

  void onDeleteAccount() {
    AppAlertDialog.showConfirm(
      title: 'deleteAccount'.tr,
      message: 'deleteAccountConfirm'.tr,
      confirmText: 'deleteAccount'.tr,
      isDestructive: true,
      onConfirm: requestDeleteAccount,
    );
  }
}
