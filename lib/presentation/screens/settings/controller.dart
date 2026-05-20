import 'package:get/get.dart';
import 'package:hedma/app/routes/routes.dart';
import 'package:hedma/app/use_cases/auth_use_case.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class SettingsController extends BaseController {
  final AuthUseCase _authUseCase = Get.put(AuthUseCase());

  void navigateToEditProfile() => Get.toNamed(Routes.editProfile);

  void navigateToFavorite() => Get.toNamed(Routes.favorite);

  void navigateToOrders() => Get.toNamed(Routes.orders);

  void navigateToContactUs() => Get.toNamed(Routes.contactUs);

  void navigateToAboutUs() => Get.toNamed(Routes.aboutUs);

  void navigateToTerms() => Get.toNamed(Routes.terms);

  void navigateToPrivacy() => Get.toNamed(Routes.privacy);

  Future<void> requestLogout() async {
    isLoading.value = true;
    final response = await _authUseCase.requestLogout();
    isLoading.value = false;
    if (!isSuccess(response)) return;
    Get.offAllNamed(Routes.signIn);
  }
}
