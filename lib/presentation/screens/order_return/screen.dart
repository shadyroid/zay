import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/order_return/controller.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';

class OrderReturnScreen extends GetView<OrderReturnController> {
  const OrderReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('orderReturn'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('${'order'.tr} #${controller.orderId}'),
              const SizedBox(height: 24),
              AppTextField(
                controller: controller.reasonController,
                hint: 'returnReasonHint'.tr,
                maxLines: 4,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'reasonRequired'.tr : null,
              ),
              const Spacer(),
              Obx(
                () => AppButton(
                  text: 'submitReturn'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.requestOrderReturn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
