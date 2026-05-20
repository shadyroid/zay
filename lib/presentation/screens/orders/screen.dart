import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/orders/controller.dart';
import 'package:hedma/presentation/screens/orders/widgets/order_item.dart';
import 'package:hedma/presentation/widgets/empty_state.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('orders'.tr),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => controller.orders.isEmpty
            ? EmptyState(message: 'emptyOrders'.tr, icon: Icons.receipt_long_outlined)
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.orders.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  return OrderItem(
                    order: order,
                    onTap: () => controller.navigateToOrderDetails(order),
                  );
                },
              ),
      ),
    );
  }
}
