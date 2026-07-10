import 'package:get/get.dart';
import 'package:zay/presentation/screens/terms/controller.dart';

class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsController());
  }
}
