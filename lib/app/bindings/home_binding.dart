import 'package:get/get.dart';
import 'package:zay/presentation/screens/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().onTabResumed();
      return;
    }
    Get.put(HomeController(), permanent: true);
  }
}
