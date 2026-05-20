import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/screens/order_details/widgets/order_items_card.dart';
import 'package:hedma/presentation/screens/order_track/controller.dart';
import 'package:hedma/presentation/screens/order_track/widgets/order_track_app_bar.dart';
import 'package:hedma/presentation/screens/order_track/widgets/order_track_delivery_card.dart';
import 'package:hedma/presentation/screens/order_track/widgets/order_track_timeline_card.dart';

class OrderTrackScreen extends GetView<OrderTrackController> {
  const OrderTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OrderTrackAppBar(onBack: controller.goBack),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.steps.isEmpty &&
            controller.order.value == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.secondary),
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
                ),
              if (controller.estimatedDelivery.value.isNotEmpty)
                const SizedBox(height: 12),
              if (order != null) ...[
                OrderItemsCard(order: order),
                const SizedBox(height: 12),
              ],
              if (controller.steps.isNotEmpty)
                OrderTrackTimelineCard(steps: controller.steps),
            ],
          ),
        );
      }),
    );
  }
}
