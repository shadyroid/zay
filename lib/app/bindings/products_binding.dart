import 'package:get/get.dart';
import 'package:hedma/presentation/screens/products/controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
  }
}
