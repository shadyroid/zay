import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/screens/orders/controller.dart';
import 'package:hedma/presentation/screens/orders/widgets/order_item.dart';
import 'package:hedma/presentation/screens/orders/widgets/orders_app_bar.dart';
import 'package:hedma/presentation/screens/orders/widgets/orders_filter_tabs.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const OrdersAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Obx(
            () => OrdersFilterTabs(
              selectedFilter: controller.selectedFilter.value,
              onFilterSelected: controller.selectFilter,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: AppProgressIndicator(
                    color: AppColors.secondary,
                  ),
                );
              }

              final orders = controller.filteredOrders;
              if (orders.isEmpty) {
                return _OrdersEmptyState();
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: orders.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderItem(
                    order: order,
                    onTap: () => controller.navigateToOrderDetails(order),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _OrdersEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_orders.svg',
              width: 64,
              height: 64,
              colorFilter: const ColorFilter.mode(
                AppColors.hint,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'emptyOrders'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
