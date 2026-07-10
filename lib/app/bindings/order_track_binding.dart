import 'package:get/get.dart';
import 'package:zay/presentation/screens/order_track/controller.dart';

class OrderTrackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderTrackController());
  }
}
