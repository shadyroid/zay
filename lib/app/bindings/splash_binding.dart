import 'package:get/get.dart';
import 'package:hedma/presentation/screens/splash/controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
