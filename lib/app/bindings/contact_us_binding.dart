import 'package:get/get.dart';
import 'package:hedma/presentation/screens/contact_us/controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }
}
