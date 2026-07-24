import 'package:get/get.dart';
import 'package:zay/presentation/screens/notifications/controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
  }
}
