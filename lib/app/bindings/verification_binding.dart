import 'package:get/get.dart';
import 'package:zay/presentation/screens/verification/controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationController());
  }
}
