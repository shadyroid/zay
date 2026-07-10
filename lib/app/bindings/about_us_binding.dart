import 'package:get/get.dart';
import 'package:zay/presentation/screens/about_us/controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}
