import 'package:get/get.dart';
import 'package:zay/presentation/screens/shop_details/controller.dart';

class ShopDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopDetailsController());
  }
}
