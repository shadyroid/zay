import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/domain/requests/sign_in_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class SignInController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> requestSignIn() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _authUseCase.requestSignIn(
      SignInRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
    isLoading.value = false;

    if (!isSuccess(response)) return;

    Get.offNamed(Routes.home);
  }

  void navigateToSignUp() => Get.toNamed(Routes.signUp);

  void navigateToForgetPassword() => Get.toNamed(Routes.forgetPassword);

  void continueAsGuest() => Get.offNamed(Routes.home);
}
