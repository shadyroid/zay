import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/verification/controller.dart';
import 'package:hedma/presentation/screens/verification/widgets/otp_input_boxes.dart';
import 'package:hedma/presentation/screens/verification/widgets/verification_header.dart';
import 'package:hedma/presentation/screens/verification/widgets/verification_keypad.dart';
import 'package:hedma/presentation/screens/verification/widgets/verification_timer_row.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_logo.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBackAppBar(onBack: controller.goBack),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  const Center(child: AppLogo()),
                  const SizedBox(height: 32),
                  const VerificationHeader(),
                  const SizedBox(height: 32),
                  Obx(
                    () => OtpInputBoxes(code: controller.otpCode.value),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => AppButton(
                      text: 'verifyOtp'.tr,
                      isLoading: controller.isLoading.value,
                      onPressed: controller.requestVerification,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => VerificationTimerRow(
                      timerText: controller.timerText,
                      canResend: controller.canResend,
                      onResend: controller.resendCode,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          VerificationKeypad(
            onDigit: controller.appendDigit,
            onBackspace: controller.removeDigit,
          ),
        ],
      ),
    );
  }
}
