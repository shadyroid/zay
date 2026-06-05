import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/screens/order_return/controller.dart';
import 'package:hedma/presentation/screens/order_return/widgets/order_return_app_bar.dart';
import 'package:hedma/presentation/screens/order_return/widgets/return_info_banner.dart';
import 'package:hedma/presentation/screens/order_return/widgets/return_reason_card.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class OrderReturnScreen extends GetView<OrderReturnController> {
  const OrderReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const OrderReturnAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'returnChooseReason'.tr,
                    style: Get.theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () {
                      if (controller.isLoading.value &&
                          controller.reasons.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: AppProgressIndicator(
                              color: AppColors.secondary,
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          for (var i = 0; i < controller.reasons.length; i++) ...[
                            ReturnReasonCard(
                              reason: controller.reasons[i],
                              isSelected: controller.selectedReasonValue.value ==
                                  controller.reasons[i].value,
                              onTap: () => controller.selectReason(
                                controller.reasons[i],
                              ),
                            ),
                            if (i < controller.reasons.length - 1)
                              const SizedBox(height: 12),
                          ],
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _AdditionalNotesSection(
                    controller: controller.notesController,
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => ReturnInfoBanner(
                      message: controller.returnPolicy.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SafeArea(
              top: false,
              child: Obx(
                () => AppButton(
                  text: 'returnConfirmation'.tr,
                  backgroundColor: AppColors.secondary,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.requestOrderReturn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdditionalNotesSection extends StatelessWidget {
  const _AdditionalNotesSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(
            style: Get.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
            children: [
              TextSpan(text: '${'additionalNotes'.tr} '),
              TextSpan(
                text: '(${'optional'.tr})',
                style: Get.theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          maxLines: 5,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
          decoration: InputDecoration(
            hintText: 'addNotes'.tr,
            hintStyle: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.hint,
                ),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.secondary),
            ),
          ),
        ),
      ],
    );
  }
}
