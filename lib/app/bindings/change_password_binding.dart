import 'package:get/get.dart';
import 'package:hedma/presentation/screens/change_password/controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
