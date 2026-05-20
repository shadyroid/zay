import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/domain/models/beans/user_bean.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class EditProfileController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    requestProfile();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> requestProfile() async {
    isLoading.value = true;
    final response = await _authUseCase.requestProfile();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    final profile = response.data;
    if (profile == null) return;
    nameController.text = profile.name ?? '';
    emailController.text = profile.email ?? '';
    phoneController.text = profile.phone ?? '';
  }

  Future<void> requestUpdateProfile() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _authUseCase.requestUpdateProfile(
      profile: UserBean(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.back();
    Get.rawSnackbar(message: response.message?.tr ?? 'profileSaved'.tr);
  }
}
