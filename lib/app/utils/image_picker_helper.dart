import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zay/presentation/bottom_sheets/image_sources/image_sources_bottom_sheet.dart';

abstract final class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> pickFromBottomSheet() async {
    final source = await ImageSourcesBottomSheet.show();
    if (source == null) return null;
    return pickFromSource(source);
  }

  static Future<XFile?> pickFromSource(ImageSource source) async {
    try {
      return await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
    } catch (_) {
      Get.rawSnackbar(message: 'imagePickFailed'.tr);
      return null;
    }
  }
}
