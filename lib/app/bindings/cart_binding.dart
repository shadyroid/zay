import 'package:get/get.dart';
import 'package:zay/presentation/screens/cart/controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController(),tag: "another_cart");
  }
}
