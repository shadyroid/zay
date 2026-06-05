import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/presentation/base/base_controller.dart';

/// Placeholder success screen after order placement.
class OrderSuccessController extends BaseController {
  final orderId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    
    orderId.value = Get.arguments['orderId'] as String? ?? '';
  }

  void goHome() => Get.offAllNamed(Routes.home);
}
