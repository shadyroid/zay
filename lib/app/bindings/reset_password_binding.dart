import 'package:get/get.dart';
import 'package:zay/presentation/screens/reset_password/controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}
