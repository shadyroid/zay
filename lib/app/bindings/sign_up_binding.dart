import 'package:get/get.dart';
import 'package:zay/presentation/screens/sign_up/controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
