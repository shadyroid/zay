import 'package:get/get.dart';
import 'package:hedma/presentation/screens/forget_password/controller.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordController());
  }
}
