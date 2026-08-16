import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class CartPriceSummary extends StatelessWidget {
  const CartPriceSummary({
    super.key,
    required this.itemCount,
    required this.subtotal,
    this.discount = 0,
    required this.shipping,
    required this.total,
  });

  final int itemCount;
  final double subtotal;
  final double discount;
  final double shipping;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: '${'subtotal'.tr} ($itemCount ${'items'.tr})',
            value: '£${subtotal.toStringAsFixed(0)}',
          ),
          if (discount > 0) ...[
            const SizedBox(height: 8),
            _SummaryRow(
              label: 'discount'.tr,
              value: '-£${discount.toStringAsFixed(0)}',
              valueColor: AppColors.orderSuccess,
            ),
          ],
          const SizedBox(height: 8),
          _SummaryRow(
            label: 'shipping'.tr,
            value: '£ ${shipping.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 8),
          _SummaryRow(
            label: 'total'.tr,
            value: '£ ${total.toStringAsFixed(0)}',
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final style = Get.theme.textTheme.bodyMedium?.copyWith(
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          color: AppColors.textPrimary,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(
          value,
          style: style?.copyWith(color: valueColor ?? AppColors.textPrimary),
        ),
      ],
    );
  }
}
