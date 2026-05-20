import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

abstract class BaseController extends GetxController {
  final RxBool isLoading = false.obs;

  bool isSuccess(BaseResponse response) {
    if (response.isSuccess) return true;
    onApiError(response);
    return false;
  }

  void onApiError(BaseResponse response) {
    if (response.statusCode == -1) {
      Get.toNamed(
        Routes.noInternet,
        arguments: {
          'currentRoute': Get.currentRoute,
          'arguments': Get.arguments,
        },
      );
      return;
    }
    if (response.statusCode == -2) {
      Get.toNamed(
        Routes.serverError,
        arguments: {
          'currentRoute': Get.currentRoute,
          'arguments': Get.arguments,
        },
      );
      return;
    }
    Get.rawSnackbar(
      message: response.message ?? 'warning'.tr,
    );
  }
}
