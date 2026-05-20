import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/sign_up/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';
import 'package:hedma/presentation/widgets/auth_scaffold.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'signUpTitle'.tr,
      subtitle: 'signUpSubtitle'.tr,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: controller.navigateToSignIn,
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: controller.nameController,
              label: 'name'.tr,
              hint: 'nameHint'.tr,
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'nameRequired'.tr : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: controller.emailController,
              label: 'email'.tr,
              hint: 'emailHint'.tr,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'emailRequired'.tr;
                if (!GetUtils.isEmail(v.trim())) return 'emailInvalid'.tr;
                return null;
              },
            ),
            const SizedBox(height: 16),
            Obx(
              () => AppTextField(
                controller: controller.passwordController,
                label: 'password'.tr,
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
                text: 'signUp'.tr,
                isLoading: controller.isLoading.value,
                onPressed: controller.requestSignUp,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('hasAccount'.tr, style: const TextStyle(color: Colors.white70)),
                TextButton(
                  onPressed: controller.navigateToSignIn,
                  child: Text('signIn'.tr,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
