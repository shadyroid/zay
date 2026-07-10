import 'package:get/get.dart';
import 'package:zay/presentation/screens/sign_in/controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
