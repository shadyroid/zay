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
  final mobileController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;
  final acceptedTerms = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    heightController.dispose();
    weightController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();
  void toggleAcceptedTerms(bool? value) => acceptedTerms.value = value ?? false;

  Future<void> requestSignUp() async {
    if (formKey.currentState?.validate() != true) return;
    if (!acceptedTerms.value) {
      Get.rawSnackbar(message: 'termsRequired'.tr);
      return;
    }

    isLoading.value = true;
    final response = await _authUseCase.requestSignUp(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      phone: mobileController.text.trim().isEmpty
          ? null
          : mobileController.text.trim(),
      height: heightController.text.trim().isEmpty
          ? null
          : heightController.text.trim(),
      weight: weightController.text.trim().isEmpty
          ? null
          : weightController.text.trim(),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    final token = response.data?.token;
    if (token != null && token.isNotEmpty) {
      await PrefsManager.setToken(token);
    }
    Get.offNamed(
      Routes.verification,
      arguments: {'email': emailController.text.trim()},
    );
  }

  void navigateToSignIn() => Get.back();

  void navigateToTerms() => Get.toNamed(Routes.terms);
}
