import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/presentation/screens/orders/controller.dart';
import 'package:zay/presentation/screens/orders/widgets/order_item.dart';
import 'package:zay/presentation/screens/orders/widgets/orders_app_bar.dart';
import 'package:zay/presentation/screens/orders/widgets/orders_filter_tabs.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

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
              Widget child;
              if (controller.isLoading.value && controller.orders.isEmpty) {
                child = const Center(
                  key: ValueKey('orders-loading'),
                  child: AppProgressIndicator(color: AppColors.primary),
                );
              } else {
                final orders = controller.filteredOrders;
                if (orders.isEmpty) {
                  child = RefreshIndicator(
                    key: const ValueKey('orders-empty-refresh'),
                    onRefresh: controller.onRefresh,
                    child: const _OrdersEmptyState(key: ValueKey('orders-empty')),
                  );
                } else {
                  child = RefreshIndicator(
                    key: ValueKey(
                      'orders-refresh-${controller.selectedFilter.value}',
                    ),
                    onRefresh: controller.onRefresh,
                    child: ListView.separated(
                      key: ValueKey(
                        'orders-${controller.selectedFilter.value}-${orders.length}',
                      ),
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      itemCount: orders.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return OrderItem(
                          order: order,
                          onTap: () =>
                              controller.navigateToOrderDetails(order),
                        ).animateStagger(index);
                      },
                    ),
                  );
                }
              }
              return AnimatedStateSwitcher(child: child);
            }),
          ),
        ],
      ),
    );
  }
}

class _OrdersEmptyState extends StatelessWidget {
  const _OrdersEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: Center(
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
                  ).animateScaleIn(begin: 0.8),
                  const SizedBox(height: 16),
                  Text(
                    'emptyOrders'.tr,
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animateEntrance(delay: const Duration(milliseconds: 80)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
