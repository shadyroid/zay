import 'package:get/get.dart';
import 'package:hedma/presentation/screens/verification/controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationController());
  }
}
