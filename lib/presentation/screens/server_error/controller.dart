import 'package:get/get.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class ServerErrorController extends BaseController {
  void retry() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final route = args['currentRoute'] as String?;
    final routeArgs = args['arguments'];
    if (route != null && route.isNotEmpty) {
      Get.offNamed(route, arguments: routeArgs);
      return;
    }
    Get.back();
  }
}
