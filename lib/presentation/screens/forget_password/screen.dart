import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/presentation/screens/forget_password/controller.dart';
import 'package:zay/presentation/screens/forget_password/widgets/forget_password_header.dart';
import 'package:zay/presentation/widgets/app_back_app_bar.dart';
import 'package:zay/presentation/widgets/app_button.dart';
import 'package:zay/presentation/widgets/app_logo.dart';
import 'package:zay/presentation/widgets/app_text_field.dart';
import 'package:zay/presentation/widgets/auth_form_layout.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBackAppBar(),
      body: AuthFormLayout(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const Center(child: AppLogo()),
              const SizedBox(height: 32),
              const ForgetPasswordHeader(),
              const SizedBox(height: 32),
              AppTextField(
                controller: controller.emailController,
                hint: 'email'.tr,
                prefixIconPath: 'assets/icons/ic_email.svg',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => controller.requestForgetPassword(),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'emailRequired'.tr;
                  }
                  if (!GetUtils.isEmail(v.trim())) {
                    return 'emailInvalid'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Obx(
                () => AppButton(
                  text: 'sendOtp'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.requestForgetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
