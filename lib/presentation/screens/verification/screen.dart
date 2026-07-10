import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/presentation/screens/verification/controller.dart';
import 'package:zay/presentation/screens/verification/widgets/otp_input_boxes.dart';
import 'package:zay/presentation/screens/verification/widgets/verification_header.dart';
import 'package:zay/presentation/screens/verification/widgets/verification_keypad.dart';
import 'package:zay/presentation/screens/verification/widgets/verification_timer_row.dart';
import 'package:zay/presentation/widgets/app_back_app_bar.dart';
import 'package:zay/presentation/widgets/app_button.dart';
import 'package:zay/presentation/widgets/app_logo.dart';
import 'package:zay/presentation/widgets/auth_form_layout.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBackAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: AuthFormLayout(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: AppLogo()),
                  const SizedBox(height: 32),
                  const VerificationHeader(),
                  const SizedBox(height: 32),
                  Obx(
                    () => OtpInputBoxes(
                      code: controller.otpCode.value,
                      controller: controller.otpTextController,
                      focusNode: controller.otpFocusNode,
                      length: VerificationController.otpLength,
                    ),
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
