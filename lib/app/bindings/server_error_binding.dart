import 'package:get/get.dart';
import 'package:zay/presentation/screens/server_error/controller.dart';

class ServerErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServerErrorController());
  }
}
