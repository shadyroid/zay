import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/presentation/base/base_controller.dart';

/// Placeholder success screen after order placement.
class OrderSuccessController extends BaseController {

  @override
  void onInit() {
    super.onInit();
  }

  void goHome() => Get.offAllNamed(Routes.home);
}
