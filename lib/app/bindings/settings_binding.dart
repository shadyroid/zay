import 'package:get/get.dart';
import 'package:hedma/presentation/screens/settings/controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
