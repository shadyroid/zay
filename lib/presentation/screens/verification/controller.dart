import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class VerificationController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  late final String email;
  late final String flow;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    email = args['email'] as String? ?? '';
    flow = args['flow'] as String? ?? 'signup';
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }

  Future<void> requestVerification() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _authUseCase.requestVerification(
      email: email,
      code: codeController.text.trim(),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    if (flow == 'reset') {
      Get.offNamed(
        Routes.resetPassword,
        arguments: {'email': email, 'code': codeController.text.trim()},
      );
      return;
    }
    Get.offNamed(Routes.home);
  }

  void goBack() => Get.back();
}
