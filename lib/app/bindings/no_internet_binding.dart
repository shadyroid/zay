import 'package:get/get.dart';
import 'package:zay/presentation/screens/no_internet/controller.dart';

class NoInternetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoInternetController());
  }
}
