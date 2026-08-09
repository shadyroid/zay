import 'dart:developer';

import 'package:get/get.dart';
import 'package:zay/app/routes/routes.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/domain/models/responses/base_response.dart';

abstract class BaseController extends GetxController {
  final RxBool isLoading = false.obs;

  bool isSuccess(BaseResponse response) {
    if (response.isSuccess) return true;
    onApiError(response);
    return false;
  }

  void onApiError(BaseResponse response) {
    if (response.statusCode == 401) {
      PrefsManager.clear();
      Get.offAllNamed(Routes.signIn);
      return;
    }
    if (response.statusCode == -1) {
      if (Get.currentRoute != Routes.noInternet) {
        Get.offNamed(
          Routes.noInternet,
          arguments: {
            'currentRoute': Get.currentRoute,
            'arguments': Get.arguments,
          },
        );
      }
      return;
    }
    if (response.statusCode == -2) {
      log("message ${response.message}");
      if (Get.currentRoute != Routes.serverError) {
        Get.offNamed(
          Routes.serverError,
          arguments: {
            'currentRoute': Get.currentRoute,
            'arguments': Get.arguments,
            'message': response.message,
          },
        );
      }
      return;
    }
    Get.rawSnackbar(message: response.message ?? 'warning'.tr);
  }
}
