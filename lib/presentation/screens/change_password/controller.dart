import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/domain/requests/change_password_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ChangePasswordController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obscureCurrentPassword = true.obs;
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;

  @override
  void onClose() {
    currentPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleCurrentPasswordVisibility() => obscureCurrentPassword.toggle();
  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();

  Future<void> requestChangePassword() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _authUseCase.requestChangePassword(
      ChangePasswordRequest(
        currentPassword: currentPasswordController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.back();
    Get.rawSnackbar(
      message: response.message?.tr ?? 'changePasswordSuccess'.tr,
    );
  }
}
