import 'package:get/get.dart';
import 'package:zay/presentation/screens/favorite/controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());
  }
}
