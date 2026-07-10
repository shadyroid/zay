import 'package:get/get.dart';
import 'package:zay/presentation/screens/order_return/controller.dart';

class OrderReturnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderReturnController());
  }
}
