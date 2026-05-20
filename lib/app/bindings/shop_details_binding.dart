import 'package:get/get.dart';
import 'package:hedma/presentation/screens/shop_details/controller.dart';

class ShopDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopDetailsController());
  }
}
