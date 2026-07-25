import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/presentation/screens/order_details/widgets/order_items_card.dart';
import 'package:zay/presentation/screens/order_track/controller.dart';
import 'package:zay/presentation/screens/order_track/widgets/order_track_app_bar.dart';
import 'package:zay/presentation/screens/order_track/widgets/order_track_delivery_card.dart';
import 'package:zay/presentation/screens/order_track/widgets/order_track_timeline_card.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class OrderTrackScreen extends GetView<OrderTrackController> {
  const OrderTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const OrderTrackAppBar(),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.steps.isEmpty &&
            controller.order.value == null) {
          return const Center(
            child: AppProgressIndicator(color: AppColors.primary),
          );
        }

        final order = controller.order.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (controller.estimatedDelivery.value.isNotEmpty)
                OrderTrackDeliveryCard(
                  estimatedDelivery: controller.estimatedDelivery.value,
                ).animateEntrance(),
              if (controller.estimatedDelivery.value.isNotEmpty)
                const SizedBox(height: 12),
              if (order != null) ...[
                OrderItemsCard(order: order).animateEntrance(
                  delay: const Duration(milliseconds: 80),
                ),
                const SizedBox(height: 12),
              ],
              if (controller.steps.isNotEmpty)
                OrderTrackTimelineCard(steps: controller.steps)
                    .animateEntrance(
                  delay: const Duration(milliseconds: 140),
                ),
            ],
          ),
        );
      }),
    );
  }
}
