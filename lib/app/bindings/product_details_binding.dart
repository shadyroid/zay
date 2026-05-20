import 'package:get/get.dart';
import 'package:hedma/presentation/screens/product_details/controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController());
  }
}
