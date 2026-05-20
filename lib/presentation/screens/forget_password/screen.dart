import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/presentation/screens/forget_password/controller.dart';
import 'package:hedma/presentation/screens/forget_password/widgets/forget_password_header.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_logo.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(onBack: controller.goBack),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Center(child: AppLogo()),
              const SizedBox(height: 32),
              const ForgetPasswordHeader(),
              const SizedBox(height: 32),
              AppTextField(
                controller: controller.emailController,
                hint: 'email'.tr,
                prefixIconPath: AppIcons.email,
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
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
