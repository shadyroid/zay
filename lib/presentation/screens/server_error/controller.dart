import 'package:get/get.dart';
import 'package:zay/presentation/base/base_controller.dart';

class ServerErrorController extends BaseController {
  void retry() {
    
    final route = Get.arguments['currentRoute'] as String?;
    final routeArgs = Get.arguments['arguments'];
    if (route != null && route.isNotEmpty) {
      Get.offNamed(route, arguments: routeArgs);
      return;
    }
    Get.back();
  }
}
