import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_input_formatters.dart';
import 'package:hedma/app/utils/egyptian_phone_util.dart';
import 'package:hedma/presentation/screens/edit_profile/controller.dart';
import 'package:hedma/presentation/screens/edit_profile/widgets/profile_avatar_header.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'editProfile'.tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Obx(
              () {
                if (controller.isProfileLoading.value) {
                  return const Center(child: AppProgressIndicator());
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Obx(
                          () => ProfileAvatarHeader(
                            name: controller.displayName.value,
                            imagePath: controller.profileImagePath.value,
                            onEditPhoto: controller.onEditPhoto,
                          ),
                        ),
                        const SizedBox(height: 24),
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
                          controller: controller.phoneController,
                          hint: 'mobileNumber'.tr,
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
                            if (value.isEmpty) return null;
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
                          textInputAction: TextInputAction.done,
                          validator: (v) {
                            final value = v?.trim() ?? '';
                            if (value.isEmpty) return null;
                            if (double.tryParse(value) == null) {
                              return 'numberInvalid'.tr;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Obx(
                () => AppButton(
                  text: 'saveChanges'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.requestUpdateProfile,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
