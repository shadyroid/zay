import 'package:get/get.dart';
import 'package:hedma/presentation/screens/about_us/controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}
