import 'package:get/get.dart';
import 'package:zay/presentation/screens/map/controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
  }
}
