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
}
