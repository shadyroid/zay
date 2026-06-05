import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/presentation/screens/order_details/widgets/order_details_section_card.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key, required this.order});

  final OrderBean order;

  @override
  Widget build(BuildContext context) {
    final itemLabel = order.itemCount == 1
        ? '${'subtotal'.tr} (${order.itemCount} ${'item'.tr})'
        : '${'subtotal'.tr} (${order.itemCount} ${'items'.tr})';

    return OrderDetailsSectionCard(
      title: 'orderSummary'.tr,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            _SummaryRow(
              label: itemLabel,
              value: '\$${order.displaySubtotal}',
            ),
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'shipping'.tr,
              value: '\$ ${order.shipping}',
            ),
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'orderDate'.tr,
              value: order.displaySummaryDate,
            ),
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'paymentMethod'.tr,
              value: order.paymentMethodLabel.tr,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(height: 1, thickness: 1, color: AppColors.border),
            ),
            _SummaryRow(
              label: 'total'.tr,
              value: '\$ ${order.total}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Get.theme.textTheme.bodyMedium?.copyWith(
          color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
          fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
        );
    final valueStyle = Get.theme.textTheme.bodyMedium?.copyWith(
          color: isTotal ? AppColors.secondary : AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        );

    return Row(
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        Text(value, style: valueStyle),
      ],
    );
  }
}
