import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/change_password/controller.dart';
import 'package:hedma/presentation/screens/change_password/widgets/change_password_header.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_logo.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';
import 'package:hedma/presentation/widgets/auth_form_layout.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBackAppBar(),
      body: AuthFormLayout(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: AppLogo()),
              const SizedBox(height: 32),
              const ChangePasswordHeader(),
              const SizedBox(height: 32),
              Obx(
                () => AppTextField(
                  controller: controller.currentPasswordController,
                  hint: 'currentPassword'.tr,
                  prefixIconPath: 'assets/icons/ic_lock.svg',
                  obscureText: controller.obscureCurrentPassword.value,
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      controller.obscureCurrentPassword.value
                          ? 'assets/icons/ic_eye_off.svg'
                          : 'assets/icons/ic_eye.svg',
                      width: 22,
                      height: 22,
                    ),
                    onPressed: controller.toggleCurrentPasswordVisibility,
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'currentPasswordRequired'.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => AppTextField(
                  controller: controller.passwordController,
                  hint: 'newPassword'.tr,
                  prefixIconPath: 'assets/icons/ic_lock_confirm.svg',
                  obscureText: controller.obscurePassword.value,
                  textInputAction: TextInputAction.next,
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      controller.obscurePassword.value
                          ? 'assets/icons/ic_eye_off.svg'
                          : 'assets/icons/ic_eye.svg',
                      width: 22,
                      height: 22,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'passwordRequired'.tr;
                    }
                    if (v.length < 6) {
                      return 'passwordMinLength'.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => AppTextField(
                  controller: controller.confirmPasswordController,
                  hint: 'confirmPassword'.tr,
                  prefixIconPath: 'assets/icons/ic_lock_confirm.svg',
                  obscureText: controller.obscureConfirm.value,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => controller.requestChangePassword(),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      controller.obscureConfirm.value
                          ? 'assets/icons/ic_eye_off.svg'
                          : 'assets/icons/ic_eye.svg',
                      width: 22,
                      height: 22,
                    ),
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
                  text: 'changePassword'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.requestChangePassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
