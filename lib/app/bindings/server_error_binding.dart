import 'package:get/get.dart';
import 'package:hedma/presentation/screens/server_error/controller.dart';

class ServerErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServerErrorController());
  }
}
