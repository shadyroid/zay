import 'package:get/get.dart';
import 'package:hedma/presentation/screens/sign_up/controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
