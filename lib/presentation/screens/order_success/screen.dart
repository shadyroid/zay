import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/screens/order_success/controller.dart';
import 'package:zay/presentation/screens/order_success/widgets/order_success_icon.dart';
import 'package:zay/presentation/screens/order_success/widgets/order_success_pattern_background.dart';

class OrderSuccessScreen extends GetView<OrderSuccessController> {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) controller.goHome();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: controller.goHome,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              const OrderSuccessPatternBackground(),
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const OrderSuccessIcon(),
                        const SizedBox(height: 28),
                        Text(
                          'congratulations'.tr,
                          textAlign: TextAlign.center,
                          style:
                              Get.theme.textTheme.headlineMedium?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'orderConfirmedLine1'.tr,
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                        ),
                        Text(
                          'orderConfirmedLine2'.tr,
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
