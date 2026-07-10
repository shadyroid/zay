import 'package:get/get.dart';
import 'package:zay/presentation/screens/review/controller.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewController());
  }
}
