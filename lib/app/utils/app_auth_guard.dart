import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/presentation/widgets/app_alert_dialog.dart';

class AppAuthGuard {
  AppAuthGuard._();

  static bool get isLoggedIn => PrefsManager.isLoggedIn;

  static Future<void> promptSignIn() {
    return AppAlertDialog.showConfirm(
      title: 'signInRequiredTitle'.tr,
      message: 'signInRequired'.tr,
      confirmText: 'signIn'.tr,
      onConfirm: () => Get.toNamed(Routes.signIn),
    );
  }

  static Future<bool> ensureAuthenticated() async {
    if (isLoggedIn) return true;
    await promptSignIn();
    return false;
  }

  static Future<T?> toNamed<T>(
    String page, {
    dynamic arguments,
    bool preventDuplicates = true,
  }) async {
    if (!await ensureAuthenticated()) return null;
    return Get.toNamed<T>(
      page,
      arguments: arguments,
      preventDuplicates: preventDuplicates,
    );
  }

  static Future<T?> offNamed<T>(
    String page, {
    dynamic arguments,
  }) async {
    if (!await ensureAuthenticated()) return null;
    return Get.offNamed<T>(page, arguments: arguments);
  }

  static Future<void> run(Future<void> Function() action) async {
    if (!await ensureAuthenticated()) return;
    await action();
  }
}
