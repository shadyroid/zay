import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/enums/order_return_reason.dart';
import 'package:hedma/presentation/screens/order_return/controller.dart';
import 'package:hedma/presentation/screens/order_return/widgets/order_return_app_bar.dart';
import 'package:hedma/presentation/screens/order_return/widgets/return_info_banner.dart';
import 'package:hedma/presentation/screens/order_return/widgets/return_reason_card.dart';
import 'package:hedma/presentation/widgets/app_button.dart';

class OrderReturnScreen extends GetView<OrderReturnController> {
  const OrderReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OrderReturnAppBar(onBack: controller.goBack),
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
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Column(
                      children: [
                        ReturnReasonCard(
                          reason: OrderReturnReason.wrongSize,
                          isSelected: controller.selectedReason.value ==
                              OrderReturnReason.wrongSize,
                          onTap: () => controller.selectReason(
                            OrderReturnReason.wrongSize,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ReturnReasonCard(
                          reason: OrderReturnReason.productProblem,
                          isSelected: controller.selectedReason.value ==
                              OrderReturnReason.productProblem,
                          onTap: () => controller.selectReason(
                            OrderReturnReason.productProblem,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _AdditionalNotesSection(
                    controller: controller.notesController,
                  ),
                  const SizedBox(height: 20),
                  const ReturnInfoBanner(),
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
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
            children: [
              TextSpan(text: '${'additionalNotes'.tr} '),
              TextSpan(
                text: '(${'optional'.tr})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
          decoration: InputDecoration(
            hintText: 'addNotes'.tr,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
