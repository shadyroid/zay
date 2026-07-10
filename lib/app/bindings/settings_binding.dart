import 'package:get/get.dart';
import 'package:zay/presentation/screens/settings/controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
