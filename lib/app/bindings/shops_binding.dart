import 'package:get/get.dart';
import 'package:zay/presentation/screens/shops/controller.dart';

class ShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopsController());
  }
}
