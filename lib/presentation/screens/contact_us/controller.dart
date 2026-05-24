import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/settings_use_case.dart';
import 'package:hedma/domain/requests/contact_us_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ContactUsController extends BaseController {
  final SettingsUseCase _settingsUseCase = Get.put(SettingsUseCase());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> requestContactUs() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _settingsUseCase.requestContactUs(
      ContactUsRequest(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        subject: subjectController.text.trim(),
        message: messageController.text.trim(),
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.back();
    Get.rawSnackbar(message: response.message ?? 'messageSent'.tr);
  }

  void goBack() => Get.back();
}
