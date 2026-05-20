import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/edit_profile/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('editProfile'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              AppTextField(
                controller: controller.nameController,
                label: 'name'.tr,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'nameRequired'.tr : null,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: controller.emailController,
                label: 'email'.tr,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'emailRequired'.tr;
                  if (!GetUtils.isEmail(v.trim())) return 'emailInvalid'.tr;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: controller.phoneController,
                label: 'phone'.tr,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              Obx(
                () => AppButton(
                  text: 'save'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.requestUpdateProfile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
