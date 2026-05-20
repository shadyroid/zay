import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/forget_password/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';
import 'package:hedma/presentation/widgets/auth_scaffold.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'forgetPasswordTitle'.tr,
      subtitle: 'forgetPasswordSubtitle'.tr,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: controller.goBack,
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            AppTextField(
              controller: controller.emailController,
              label: 'email'.tr,
              hint: 'emailHint'.tr,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'emailRequired'.tr;
                if (!GetUtils.isEmail(v.trim())) return 'emailInvalid'.tr;
                return null;
              },
            ),
            const SizedBox(height: 24),
            Obx(
              () => AppButton(
                text: 'sendCode'.tr,
                isLoading: controller.isLoading.value,
                onPressed: controller.requestForgetPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
