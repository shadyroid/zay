import 'package:get/get.dart';
import 'package:hedma/presentation/screens/terms/controller.dart';

class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsController());
  }
}
