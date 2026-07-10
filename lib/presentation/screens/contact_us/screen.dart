import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_input_formatters.dart';
import 'package:zay/app/utils/egyptian_phone_util.dart';
import 'package:zay/presentation/screens/contact_us/controller.dart';
import 'package:zay/presentation/screens/contact_us/widgets/contact_us_header.dart';
import 'package:zay/presentation/screens/contact_us/widgets/contact_us_labeled_field.dart';
import 'package:zay/presentation/widgets/app_back_app_bar.dart';
import 'package:zay/presentation/widgets/app_button.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'contactUs'.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ContactUsHeader(),
              const SizedBox(height: 28),
              ContactUsLabeledField(
                label: 'name'.tr,
                controller: controller.nameController,
                hint: 'name'.tr,
                textInputAction: TextInputAction.next,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'nameRequired'.tr : null,
              ),
              const SizedBox(height: 16),
              ContactUsLabeledField(
                label: 'email'.tr,
                controller: controller.emailController,
                hint: 'emailHint'.tr,
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
              const SizedBox(height: 16),
              ContactUsLabeledField(
                label: 'phone'.tr,
                controller: controller.phoneController,
                hint: 'phone'.tr,
                keyboardType: TextInputType.phone,
                inputFormatters: AppInputFormatters.phone,
                textInputAction: TextInputAction.next,
                validator: (v) => EgyptianPhoneUtil.validate(v, required: true),
              ),
              const SizedBox(height: 16),
              ContactUsLabeledField(
                label: 'subject'.tr,
                controller: controller.subjectController,
                hint: 'subject'.tr,
                textInputAction: TextInputAction.next,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'subjectRequired'.tr : null,
              ),
              const SizedBox(height: 16),
              ContactUsLabeledField(
                label: 'description'.tr,
                controller: controller.messageController,
                hint: 'description'.tr,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'descriptionRequired'.tr
                    : null,
              ),
              const SizedBox(height: 24),
              Obx(
                () => AppButton(
                  text: 'send'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.requestContactUs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
