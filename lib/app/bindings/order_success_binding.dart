import 'package:get/get.dart';
import 'package:zay/presentation/screens/order_success/controller.dart';

class OrderSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderSuccessController());
  }
}
