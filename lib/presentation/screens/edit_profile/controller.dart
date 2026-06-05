import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/app/utils/egyptian_phone_util.dart';
import 'package:hedma/domain/requests/update_profile_request.dart';
import 'package:hedma/app/utils/image_picker_helper.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class EditProfileController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final displayName = ''.obs;
  final profileImagePath = RxnString();
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
    heightController.text = profile.height?.toString() ?? '';
    weightController.text = profile.weight?.toString() ?? '';
    displayName.value = profile.name ?? '';
    profileImagePath.value = profile.avatarUrl;
  }

  Future<void> onEditPhoto() async {
    final file = await ImagePickerHelper.pickFromBottomSheet();
    if (file == null) return;
    profileImagePath.value = file.path;
  }

  Future<void> requestUpdateProfile() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;

    final imagePath = profileImagePath.value;
    final localAvatarPath = imagePath != null && !imagePath.startsWith('http')
        ? imagePath
        : null;

    final response = await _authUseCase.requestUpdateProfile(
      UpdateProfileRequest(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: EgyptianPhoneUtil.normalize(phoneController.text.trim()),
        height: heightController.text.trim(),
        weight: weightController.text.trim(),
        avatarPath: localAvatarPath,
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    displayName.value = nameController.text.trim();
    Get.back();
    Get.rawSnackbar(message: response.message?.tr ?? 'profileSaved'.tr);
  }

  
}
