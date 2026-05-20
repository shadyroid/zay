import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.order,
    required this.onTap,
  });

  final OrderBean order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${'order'.tr} #${order.id}'),
        subtitle: Text('${order.status} • ${order.date}'),
        trailing: Text(
          '\$${order.total}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
