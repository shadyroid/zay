import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/presentation/bottom_sheets/image_sources/widgets/image_source_item.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourcesBottomSheet extends StatelessWidget {
  const ImageSourcesBottomSheet({super.key});

  static Future<ImageSource?> show() {
    return Get.bottomSheet<ImageSource?>(
      const ImageSourcesBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            ImageSourceItem(
              iconPath: AppIcons.cameraOutline,
              label: 'takeFullPhoto'.tr,
              onTap: () => Get.back(result: ImageSource.camera),
            ),
            ImageSourceItem(
              iconPath: AppIcons.galleryAdd,
              label: 'choosePhotoFromGallery'.tr,
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
