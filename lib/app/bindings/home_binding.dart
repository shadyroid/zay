import 'package:get/get.dart';
import 'package:hedma/presentation/screens/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
