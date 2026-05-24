import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/app/use_cases/settings_use_case.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/presentation/base/base_controller.dart';
import 'package:hedma/presentation/bottom_sheets/languages/languages_bottom_sheet.dart';
import 'package:hedma/presentation/widgets/app_alert_dialog.dart';
import 'package:share_plus/share_plus.dart';

class SettingsController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());
  final SettingsUseCase _settingsUseCase = Get.put(SettingsUseCase());

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
    final current =
        _settingsUseCase.getLocale() ?? Get.locale?.languageCode ?? 'en';
    LanguagesBottomSheet.show(
      selectedCode: current,
      onSelected: _setLocale,
    );
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
    Get.rawSnackbar(
      message: response.message?.tr ?? 'deleteAccountSuccess'.tr,
    );
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
