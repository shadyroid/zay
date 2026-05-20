import 'package:get/get.dart';
import 'package:hedma/app/use_cases/settings_use_case.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class AboutUsController extends BaseController {
  final SettingsUseCase _settingsUseCase = Get.put(SettingsUseCase());

  final content = ''.obs;

  @override
  void onInit() {
    super.onInit();
    requestAboutUs();
  }

  Future<void> requestAboutUs() async {
    isLoading.value = true;
    final response = await _settingsUseCase.requestAboutUs();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    content.value = response.data?.tr ?? '';
  }
}
