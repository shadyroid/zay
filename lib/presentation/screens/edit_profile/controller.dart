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
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final locationController = TextEditingController();
  final displayName = ''.obs;
  final isProfileLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(_syncDisplayName);
    requestProfile();
  }

  @override
  void onClose() {
    nameController.removeListener(_syncDisplayName);
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    heightController.dispose();
    weightController.dispose();
    locationController.dispose();
    super.onClose();
  }

  void _syncDisplayName() => displayName.value = nameController.text;

  Future<void> requestProfile() async {
    isProfileLoading.value = true;
    final response = await _authUseCase.requestProfile();
    isProfileLoading.value = false;
    if (!isSuccess(response)) return;

    final profile = response.data;
    if (profile == null) return;

    nameController.text = profile.name ?? '';
    emailController.text = profile.email ?? '';
    phoneController.text = profile.phone ?? '';
    heightController.text = profile.height ?? '';
    weightController.text = profile.weight ?? '';
    locationController.text = profile.location ?? '';
    displayName.value = profile.name ?? '';
  }

  void onEditPhoto() {
    Get.rawSnackbar(message: 'photoPickerComingSoon'.tr);
  }

  Future<void> onLocationTap() async {
    final editController =
        TextEditingController(text: locationController.text);
    final result = await Get.dialog<String>(
      AlertDialog(
        title: Text('location'.tr),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(hintText: 'locationHint'.tr),
          textInputAction: TextInputAction.done,
        ),
        actions: [
          TextButton(onPressed: Get.back, child: Text('cancel'.tr)),
          TextButton(
            onPressed: () => Get.back(result: editController.text.trim()),
            child: Text('save'.tr),
          ),
        ],
      ),
    );
    editController.dispose();
    if (result != null) {
      locationController.text = result;
    }
  }

  Future<void> requestUpdateProfile() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    final response = await _authUseCase.requestUpdateProfile(
      profile: UserBean(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        height: heightController.text.trim(),
        weight: weightController.text.trim(),
        location: locationController.text.trim(),
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    displayName.value = nameController.text.trim();
    Get.back();
    Get.rawSnackbar(message: response.message?.tr ?? 'profileSaved'.tr);
  }

  void goBack() => Get.back();
}
