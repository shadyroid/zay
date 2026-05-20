import 'dart:async';

import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class VerificationController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  static const int otpLength = 4;
  static const int resendSeconds = 59;

  final otpCode = ''.obs;
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
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
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
    otpCode.value += digit;
  }

  void removeDigit() {
    if (otpCode.value.isEmpty) return;
    otpCode.value = otpCode.value.substring(0, otpCode.value.length - 1);
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

    if (flow == 'reset') {
      isLoading.value = true;
      final response = await _authUseCase.requestForgetPassword(email: email);
      isLoading.value = false;
      if (!isSuccess(response)) return;
    }

    otpCode.value = '';
    _startTimer();
    Get.rawSnackbar(message: 'otpResent'.tr);
  }

  Future<void> requestVerification() async {
    if (otpCode.value.length < otpLength) {
      Get.rawSnackbar(message: 'codeInvalid'.tr);
      return;
    }

    isLoading.value = true;
    final response = await _authUseCase.requestVerification(
      email: email,
      code: otpCode.value,
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    if (flow == 'reset') {
      Get.offNamed(
        Routes.resetPassword,
        arguments: {'email': email, 'code': otpCode.value},
      );
      return;
    }
    Get.offNamed(Routes.home);
  }

  void goBack() => Get.back();
}
