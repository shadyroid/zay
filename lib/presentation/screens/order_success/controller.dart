import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/presentation/base/base_controller.dart';

/// Placeholder success screen after order placement.
class OrderSuccessController extends BaseController {
  final orderId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    orderId.value = args['orderId'] as String? ?? '';
  }

  void goHome() => Get.offAllNamed(Routes.home);
}
