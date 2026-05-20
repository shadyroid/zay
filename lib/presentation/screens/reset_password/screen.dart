import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/reset_password/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';
import 'package:hedma/presentation/widgets/auth_scaffold.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'resetPasswordTitle'.tr,
      subtitle: 'resetPasswordSubtitle'.tr,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Obx(
              () => AppTextField(
                controller: controller.passwordController,
                label: 'newPassword'.tr,
                obscureText: controller.obscurePassword.value,
                suffixIcon: IconButton(
                  icon: Icon(controller.obscurePassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: controller.togglePasswordVisibility,
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'passwordRequired'.tr;
                  if (v.length < 6) return 'passwordMinLength'.tr;
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => AppTextField(
                controller: controller.confirmPasswordController,
                label: 'confirmPassword'.tr,
                obscureText: controller.obscureConfirm.value,
                suffixIcon: IconButton(
                  icon: Icon(controller.obscureConfirm.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: controller.toggleConfirmVisibility,
                ),
                validator: (v) {
                  if (v != controller.passwordController.text) {
                    return 'passwordMismatch'.tr;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => AppButton(
                text: 'resetPassword'.tr,
                isLoading: controller.isLoading.value,
                onPressed: controller.requestResetPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
