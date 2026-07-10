import 'package:get/get.dart';
import 'package:zay/presentation/screens/orders/controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
  }
}
