import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppAlertDialog {
  AppAlertDialog._();

  static Future<T?> showConfirm<T>({
    required String title,
    required String message,
    required String confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    bool isDestructive = false,
  }) {
    return Get.dialog<T>(
      CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(message),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: Get.back,
            child: Text(cancelText ?? 'cancel'.tr),
          ),
          CupertinoDialogAction(
            isDestructiveAction: isDestructive,
            onPressed: () {
              Get.back();
              onConfirm?.call();
            },
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  static Future<String?> showPasswordConfirm({
    required String title,
    required String message,
    required String confirmText,
    String? cancelText,
    bool isDestructive = false,
  }) {
    final passwordController = TextEditingController();

    return Get.dialog<String>(
      CupertinoAlertDialog(
        title: Text(title),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Text(message),
            ),
            CupertinoTextField(
              controller: passwordController,
              obscureText: true,
              placeholder: 'currentPassword'.tr,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              passwordController.dispose();
              Get.back();
            },
            child: Text(cancelText ?? 'cancel'.tr),
          ),
          CupertinoDialogAction(
            isDestructiveAction: isDestructive,
            onPressed: () {
              final password = passwordController.text;
              passwordController.dispose();
              Get.back(result: password);
            },
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
