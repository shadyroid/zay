import 'package:get/get.dart';
import 'package:hedma/presentation/screens/edit_profile/controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
