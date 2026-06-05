import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_input_formatters.dart';
import 'package:hedma/app/utils/egyptian_phone_util.dart';
import 'package:hedma/presentation/screens/sign_up/controller.dart';
import 'package:hedma/presentation/screens/sign_up/widgets/sign_up_header.dart';
import 'package:hedma/presentation/screens/sign_up/widgets/sign_up_terms_checkbox.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    appBar: const AppBackAppBar(),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SignUpHeader(onLogIn: controller.navigateToSignIn),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    controller: controller.nameController,
                    hint: 'fullName'.tr,
                    prefixIconPath: 'assets/icons/ic_person.svg',
                    textInputAction: TextInputAction.next,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'nameRequired'.tr
                        : null,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: controller.emailController,
                    hint: 'email'.tr,
                    prefixIconPath: 'assets/icons/ic_email.svg',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
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
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: controller.mobileController,
                    hint: 'mobileOptional'.tr,
                    prefixIconPath: 'assets/icons/ic_phone.svg',
                    keyboardType: TextInputType.phone,
                    inputFormatters: AppInputFormatters.phone,
                    textInputAction: TextInputAction.next,
                    validator: (v) => EgyptianPhoneUtil.validate(v),
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: controller.heightController,
                    hint: 'height'.tr,
                    prefixIconPath: 'assets/icons/ic_height.svg',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: AppInputFormatters.decimal,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      final value = v?.trim() ?? '';
                      if (value.isEmpty) return 'heightRequired'.tr;
                      if (double.tryParse(value) == null) {
                        return 'numberInvalid'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: controller.weightController,
                    hint: 'weight'.tr,
                    prefixIconPath: 'assets/icons/ic_weight.svg',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: AppInputFormatters.decimal,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      final value = v?.trim() ?? '';
                      if (value.isEmpty) return 'weightRequired'.tr;
                      if (double.tryParse(value) == null) {
                        return 'numberInvalid'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => AppTextField(
                      controller: controller.passwordController,
                      hint: 'password'.tr,
                      prefixIconPath: 'assets/icons/ic_lock.svg',
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
                  const SizedBox(height: 12),
                  Obx(
                    () => AppTextField(
                      controller: controller.confirmPasswordController,
                      hint: 'confirmPassword'.tr,
                      prefixIconPath: 'assets/icons/ic_lock_confirm.svg',
                      obscureText: controller.obscureConfirm.value,
                      textInputAction: TextInputAction.done,
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
                  const SizedBox(height: 16),
                  Obx(
                    () => SignUpTermsCheckbox(
                      value: controller.acceptedTerms.value,
                      onChanged: controller.toggleAcceptedTerms,
                      onTermsTap: controller.navigateToTerms,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => AppButton(
                      text: 'createAccount'.tr,
                      isLoading: controller.isLoading.value,
                      onPressed: controller.requestSignUp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
        );
  }
}
