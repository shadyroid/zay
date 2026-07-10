import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/auth_use_case.dart';
import 'package:zay/domain/requests/sign_in_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

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

    if (response.statusCode == 403) {
      Get.offNamed(
        Routes.verification,
        arguments: {'email': emailController.text.trim(), 'flow': 'signin'},
      );
    } else if (!isSuccess(response)) {
      return;
    } else {
      Get.offNamed(Routes.home);
    }
  }

  void navigateToSignUp() => Get.toNamed(Routes.signUp);

  void navigateToForgetPassword() => Get.toNamed(Routes.forgetPassword);

  void continueAsGuest() => Get.offNamed(Routes.home);
}
