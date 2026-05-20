import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    _start();
  }

  Future<void> _start() async {
    await Future.delayed(
      const Duration(seconds: Constants.splashDelaySeconds),
    );
    _navigateNext();
  }

  void _navigateNext() {
    if (PrefsManager.token != null && PrefsManager.token!.isNotEmpty) {
      Get.offNamed(Routes.home);
      return;
    }
    Get.offNamed(Routes.signIn);
  }
}
