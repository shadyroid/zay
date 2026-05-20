import 'package:get/get.dart';
import 'package:hedma/app/use_cases/settings_use_case.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class PrivacyController extends BaseController {
  final SettingsUseCase _settingsUseCase = Get.put(SettingsUseCase());

  final content = ''.obs;

  @override
  void onInit() {
    super.onInit();
    requestPrivacy();
  }

  Future<void> requestPrivacy() async {
    isLoading.value = true;
    final response = await _settingsUseCase.requestPrivacy();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    content.value = response.data ?? '';
  }

  void goBack() => Get.back();
}
