import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/order_details/controller.dart';
import 'package:hedma/presentation/screens/order_details/widgets/order_detail_item.dart';
import 'package:hedma/presentation/widgets/app_button.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              '${'order'.tr} #${controller.order.value?.id ?? controller.orderId}',
            )),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () {
          final order = controller.order.value;
          if (order == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OrderDetailItem(label: 'orderStatus'.tr, value: order.status),
                OrderDetailItem(label: 'orderDate'.tr, value: order.date),
                OrderDetailItem(
                  label: 'orderItems'.tr,
                  value: '${order.itemCount}',
                ),
                OrderDetailItem(
                  label: 'orderTotal'.tr,
                  value: '\$${order.total}',
                ),
                const Spacer(),
                AppButton(
                  text: 'trackOrder'.tr,
                  onPressed: controller.navigateToTrack,
                ),
                const SizedBox(height: 12),
                AppButton(
                  text: 'returnOrder'.tr,
                  onPressed: controller.navigateToReturn,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF757575), Color(0xFF424242)],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
