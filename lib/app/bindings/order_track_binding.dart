import 'package:get/get.dart';
import 'package:hedma/presentation/screens/order_track/controller.dart';

class OrderTrackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderTrackController());
  }
}
