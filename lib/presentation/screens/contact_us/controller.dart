import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/settings_use_case.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ContactUsController extends BaseController {
  final SettingsUseCase _settingsUseCase = Get.put(SettingsUseCase());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> requestSendMessage() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _settingsUseCase.requestSendMessage(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      message: messageController.text.trim(),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.back();
    Get.rawSnackbar(message: response.message?.tr ?? 'messageSent'.tr);
  }

  void goBack() => Get.back();

  void openWhatsApp() => Get.rawSnackbar(message: 'socialLinkComingSoon'.tr);

  void openFacebook() => Get.rawSnackbar(message: 'socialLinkComingSoon'.tr);

  void openTwitter() => Get.rawSnackbar(message: 'socialLinkComingSoon'.tr);
}
