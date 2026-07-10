import 'package:get/get.dart';
import 'package:zay/presentation/screens/reviews/controller.dart';

class ReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewsController());
  }
}
