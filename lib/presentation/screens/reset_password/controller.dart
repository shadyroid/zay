import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/domain/requests/reset_password_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ResetPasswordController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;
  late final String email;
  late final String otp;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    email = args['email'] as String? ?? '';
    otp = args['otp'] as String? ?? args['code'] as String? ?? '';
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();

  Future<void> requestResetPassword() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _authUseCase.requestResetPassword(
      ResetPasswordRequest(
        email: email,
        otp: otp,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.offAllNamed(Routes.signIn);
    Get.rawSnackbar(message: 'resetPasswordSuccess'.tr);
  }

  void goBack() => Get.back();
}
