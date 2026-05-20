import 'package:get/get.dart';
import 'package:hedma/presentation/screens/privacy/controller.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyController());
  }
}
