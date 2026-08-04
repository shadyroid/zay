import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/screens/order_details/controller.dart';
import 'package:zay/presentation/screens/order_details/widgets/order_customer_card.dart';
import 'package:zay/presentation/screens/order_details/widgets/order_details_actions.dart';
import 'package:zay/presentation/screens/order_details/widgets/order_details_app_bar.dart';
import 'package:zay/presentation/screens/order_details/widgets/order_items_card.dart';
import 'package:zay/presentation/screens/order_details/widgets/order_summary_card.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const OrderDetailsAppBar(),
      body: Obx(() {
        if (controller.isLoading.value && controller.order.value == null) {
          return const Center(
            child: AppProgressIndicator(color: AppColors.primary),
          );
        }

        final order = controller.order.value;
        if (order == null) {
          return Center(
            child: Text(
              'emptyOrders'.tr,
              style: Get.theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  children: [
                    OrderCustomerCard(order: order),
                    const SizedBox(height: 12),
                    OrderItemsCard(order: order),
                    const SizedBox(height: 12),
                    OrderSummaryCard(order: order),
                  ],
                ),
              ),
            ),
            OrderDetailsActions(
              onReturn: controller.navigateToReturn,
              onTrack: controller.navigateToTrack,
              onReview: order.isCompleted ? controller.navigateToReview : null,
              onPay: order.needsPayment ? controller.onPay : null,
            ),
          ],
        );
      }),
    );
  }
}
