import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/domain/requests/forget_password_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ForgetPasswordController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> requestForgetPassword() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _authUseCase.requestForgetPassword(
      ForgetPasswordRequest(email: emailController.text.trim()),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.toNamed(
      Routes.verification,
      arguments: {'email': emailController.text.trim(), 'flow': 'reset'},
    );
  }

  
}
