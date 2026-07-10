import 'package:get/get.dart';
import 'package:zay/presentation/screens/order_details/controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailsController());
  }
}
