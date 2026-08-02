import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
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
              const OrderSuccessPatternBackground()
                  .animate()
                  .fadeIn(duration: AppMotion.slow),
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const OrderSuccessIcon()
                            .animate()
                            .fadeIn(duration: AppMotion.normal)
                            .scale(
                              begin: const Offset(0.4, 0.4),
                              end: const Offset(1, 1),
                              duration: AppMotion.slow,
                              curve: Curves.easeOutBack,
                            ),
                        const SizedBox(height: 28),
                        Text(
                          'congratulations'.tr,
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.headlineMedium?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ).animateEntrance(
                          delay: const Duration(milliseconds: 180),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'orderConfirmedLine1'.tr,
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ).animateEntrance(
                          delay: const Duration(milliseconds: 280),
                        ),
                        Text(
                          'orderConfirmedLine2'.tr,
                          textAlign: TextAlign.center,
                          style: Get.theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ).animateEntrance(
                          delay: const Duration(milliseconds: 340),
                        ),
                        if (controller.isCardPayment) ...[
                          const SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F6EF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  size: 22,
                                  color: AppColors.orderSuccess,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'orderCardPaymentPendingApproval'.tr,
                                    textAlign: TextAlign.start,
                                    style: Get.theme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColors.orderSuccess,
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).animateEntrance(
                            delay: const Duration(milliseconds: 420),
                          ),
                        ],
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
