import 'package:get/get.dart';
import 'package:zay/presentation/screens/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
