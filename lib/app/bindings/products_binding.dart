import 'package:get/get.dart';
import 'package:zay/presentation/screens/products/controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
  }
}
