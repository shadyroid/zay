import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/verification/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';
import 'package:hedma/presentation/widgets/auth_scaffold.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'verificationTitle'.tr,
      subtitle: 'verificationSubtitle'.tr,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: controller.goBack,
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            AppTextField(
              controller: controller.codeController,
              label: 'verificationCode'.tr,
              hint: 'verificationCodeHint'.tr,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'codeRequired'.tr;
                if (v.trim().length < 4) return 'codeInvalid'.tr;
                return null;
              },
            ),
            const SizedBox(height: 24),
            Obx(
              () => AppButton(
                text: 'verify'.tr,
                isLoading: controller.isLoading.value,
                onPressed: controller.requestVerification,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
