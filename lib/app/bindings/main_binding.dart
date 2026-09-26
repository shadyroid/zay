import 'package:get/get.dart';
import 'package:zay/presentation/screens/cart/controller.dart';
import 'package:zay/presentation/screens/cart/screen.dart';
import 'package:zay/presentation/screens/home/controller.dart';
import 'package:zay/presentation/screens/main/controller.dart';
import 'package:zay/presentation/screens/settings/controller.dart';
import 'package:zay/presentation/screens/settings/screen.dart';
import 'package:zay/presentation/screens/shops/controller.dart';
import 'package:zay/presentation/screens/shops/screen.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ShopsController());
    Get.lazyPut(() => CartController(),tag: "main_cart");
    Get.lazyPut(() => SettingsController());
  }
}
