import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/type_bean.dart';
import 'package:zay/presentation/bottom_sheets/types/types_bottom_sheet_controller.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class TypesBottomSheet extends GetView<TypesBottomSheetController> {
  const TypesBottomSheet({super.key});

  static Future<TypeBean?> show() async {
    Get.put(TypesBottomSheetController());
    try {
      return await Get.bottomSheet<TypeBean?>(
        const TypesBottomSheet(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } finally {
      if (Get.isRegistered<TypesBottomSheetController>()) {
        Get.delete<TypesBottomSheetController>();
      }
    }
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
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'selectImageType'.tr,
                  style: Get.theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: AppProgressIndicator()),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...controller.types.map(
                    (type) => InkWell(
                      onTap: () => Get.back(result: type),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            type.name ?? '',
                            style: Get.theme.textTheme.bodyLarge?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
