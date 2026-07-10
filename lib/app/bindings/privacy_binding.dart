import 'package:get/get.dart';
import 'package:zay/presentation/screens/privacy/controller.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyController());
  }
}
