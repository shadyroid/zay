import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/domain/requests/resend_verification_code_request.dart';
import 'package:hedma/domain/requests/verification_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

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
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    email = args['email'] as String? ?? '';
    flow = args['flow'] as String? ?? 'signup';

    otpTextController = TextEditingController();
    otpTextController.addListener(_onOtpTextChanged);
    otpFocusNode.addListener(_onFocusChanged);

    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpTextController.removeListener(_onOtpTextChanged);
    otpFocusNode.removeListener(_onFocusChanged);
    otpTextController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }

  void _onFocusChanged() {
    otpCode.refresh();
  }

  void _onOtpTextChanged() {
    final digitsOnly = otpTextController.text.replaceAll(RegExp(r'\D'), '');
    final clipped = digitsOnly.length > otpLength
        ? digitsOnly.substring(0, otpLength)
        : digitsOnly;

    if (otpTextController.text != clipped) {
      otpTextController.value = TextEditingValue(
        text: clipped,
        selection: TextSelection.collapsed(offset: clipped.length),
      );
      return;
    }

    if (otpCode.value != clipped) {
      otpCode.value = clipped;
    }
  }

  void _syncTextController() {
    if (otpTextController.text == otpCode.value) return;

    otpTextController.value = TextEditingValue(
      text: otpCode.value,
      selection: TextSelection.collapsed(offset: otpCode.value.length),
    );
  }

  String get timerText {
    final seconds = secondsRemaining.value;
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  bool get canResend => secondsRemaining.value == 0;

  void appendDigit(String digit) {
    if (otpCode.value.length >= otpLength) return;
    otpCode.value = '${otpCode.value}$digit';
    _syncTextController();
  }

  void removeDigit() {
    if (otpCode.value.isEmpty) return;
    otpCode.value = otpCode.value.substring(0, otpCode.value.length - 1);
    _syncTextController();
  }

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
    _syncTextController();
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
    if (flow == 'signin') {
      Get.offNamed(Routes.signIn);
      return;
    }

    isLoading.value = true;
    final response = await _authUseCase.requestVerification(
      VerificationRequest(email: email, otp: otpCode.value),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.offNamed(Routes.home);
  }

  
}
