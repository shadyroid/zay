import 'package:get/get.dart';
import 'package:zay/presentation/base/base_controller.dart';

class NoInternetController extends BaseController {
  void retry() {
    Get.offNamed(Get.arguments['currentRoute'], arguments: Get.arguments['arguments']);
  }
}
