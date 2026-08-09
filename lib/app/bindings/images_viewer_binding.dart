import 'package:get/get.dart';
import 'package:zay/presentation/screens/images_viewer/controller.dart';

class ImagesViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ImagesViewerController.new);
  }
}
