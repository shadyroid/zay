import 'package:get/get.dart';
import 'package:zay/presentation/screens/try_on/controller.dart';

class TryOnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TryOnController());
  }
}
