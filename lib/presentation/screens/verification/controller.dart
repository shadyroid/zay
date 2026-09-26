import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/use_cases/auth_use_case.dart';
import 'package:zay/domain/models/requests/resend_verification_code_request.dart';
import 'package:zay/domain/models/requests/verification_request.dart';
import 'package:zay/presentation/base/base_controller.dart';

class VerificationController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  static const int otpLength = 6;
  static const int resendSeconds = 59;

  final otpCode = ''.obs;
  final otpFocusNode = FocusNode();
  late final TextEditingController otpTextController;
  final secondsRemaining = resendSeconds.obs;

  late final String email;
  late final String flow;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments['email'] as String? ?? '';
    flow = Get.arguments['flow'] as String? ?? 'signup';

    otpTextController = TextEditingController();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpTextController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }

  void onOtpChanged(String value) {
    otpCode.value = value;
  }

  String get timerText {
    final seconds = secondsRemaining.value;
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  bool get canResend => secondsRemaining.value == 0;

  void _startTimer() {
    secondsRemaining.value = resendSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value <= 0) {
        timer.cancel();
        return;
      }
      secondsRemaining.value--;
    });
  }

  Future<void> resendCode() async {
    if (!canResend) return;

    isLoading.value = true;
    final response = await _authUseCase.requestResendVerificationCode(
      ResendVerificationCodeRequest(email: email, flow: flow),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    otpCode.value = '';
    otpTextController.clear();
    _startTimer();
    Get.rawSnackbar(message: 'otpResent'.tr);
  }

  Future<void> requestVerification() async {
    if (otpCode.value.length < otpLength) {
      Get.rawSnackbar(message: 'codeInvalid'.tr);
      return;
    }

    if (flow == 'reset') {
      Get.offNamed(
        Routes.resetPassword,
        arguments: {'email': email, 'otp': otpCode.value},
      );
      return;
    }

    isLoading.value = true;
    final response = await _authUseCase.requestVerification(
      VerificationRequest(email: email, otp: otpCode.value),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.offAllNamed(Routes.main);
  }
}
