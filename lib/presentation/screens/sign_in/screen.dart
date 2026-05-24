import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/presentation/screens/sign_in/controller.dart';
import 'package:hedma/presentation/screens/sign_in/widgets/guest_continue_button.dart';
import 'package:hedma/presentation/screens/sign_in/widgets/sign_in_welcome_header.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_logo.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';
import 'package:hedma/presentation/widgets/auth_form_layout.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AuthFormLayout(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: AppLogo()),
                const SizedBox(height: 32),
                SignInWelcomeHeader(
                  onCreateAccount: controller.navigateToSignUp,
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: controller.emailController,
                  hint: 'email'.tr,
                  prefixIconPath: AppIcons.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'emailRequired'.tr;
                    }
                    if (!GetUtils.isEmail(value.trim())) {
                      return 'emailInvalid'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(
                  () => AppTextField(
                    controller: controller.passwordController,
                    hint: 'password'.tr,
                    prefixIconPath: AppIcons.lock,
                    obscureText: controller.obscurePassword.value,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => controller.requestSignIn(),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        controller.obscurePassword.value
                            ? AppIcons.eyeOff
                            : AppIcons.eye,
                        width: 22,
                        height: 22,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'passwordRequired'.tr;
                      }
                      if (value.length < 6) {
                        return 'passwordMinLength'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: controller.navigateToForgetPassword,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'forgotPassword'.tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textPrimary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.textPrimary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Obx(
                  () => AppButton(
                    text: 'signIn'.tr,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.requestSignIn,
                  ),
                ),
                const SizedBox(height: 16),
                GuestContinueButton(
                  onPressed: controller.continueAsGuest,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
