import 'package:get/get.dart';
import 'package:hedma/presentation/screens/shops/controller.dart';

class ShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopsController());
  }
}
