import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class SignUpController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();

  Future<void> requestSignUp() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _authUseCase.requestSignUp(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    final token = response.data?.token;
    if (token != null && token.isNotEmpty) {
      await PrefsManager.setToken(token);
    }
    Get.offNamed(Routes.verification, arguments: {'email': emailController.text.trim()});
  }

  void navigateToSignIn() => Get.offNamed(Routes.signIn);
}
