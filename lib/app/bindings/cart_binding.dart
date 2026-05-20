import 'package:get/get.dart';
import 'package:hedma/presentation/screens/cart/controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
