import 'package:get/get.dart';
import 'package:zay/app/utils/app_auth_guard.dart';
import 'package:zay/presentation/base/base_controller.dart';
import 'package:zay/presentation/screens/cart/controller.dart';

class MainController extends BaseController {
  final currentIndex = 0.obs;
  final builtTabs = <bool>[true, false, false, false].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Map && Get.arguments.contains("index")) {
      onTabSelected(Get.arguments["index"]);
    }
  }

  void onTabSelected(int index) {
    if (index == 1) {
      openShops();
    } else if (index == 2) {
      openCart();
    } else {
      builtTabs[index] = true;
      currentIndex.value = index;
    }
  }

  void openShops() {
    builtTabs[1] = true;
    currentIndex.value = 1;
  }

  Future<void> openCart() async {
    if (!await AppAuthGuard.ensureAuthenticated()) return;
    builtTabs[2] = true;
    currentIndex.value = 2;
    if (Get.isRegistered<CartController>(tag: "main_cart")){
      Get.find<CartController>(tag: "main_cart").requestCart();
    }
  }
}
