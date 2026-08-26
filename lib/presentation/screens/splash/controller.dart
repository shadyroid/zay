import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/app/utils/deep_links_util.dart';
import 'package:zay/app/utils/notifications_util.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/presentation/base/base_controller.dart';

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
    if (PrefsManager.token?.isNotEmpty == true) {
      Get.offNamed(Routes.home);
      NotificationsUtil.handelInitialLink();
    }else{
      Get.offNamed(Routes.signIn);
    }
    DeepLinksUtil.handleInitialLink();
  }
}
