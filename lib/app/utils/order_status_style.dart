import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';

class OrderStatusStyle {
  const OrderStatusStyle({
    required this.labelKey,
    required this.backgroundColor,
    required this.textColor,
  });

  final String labelKey;
  final Color backgroundColor;
  final Color textColor;

  static OrderStatusStyle forStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const OrderStatusStyle(
          labelKey: 'orderStatusPending',
          backgroundColor: Color(0xFFFFF3CD),
          textColor: Color(0xFFE67E22),
        );
      case 'confirmed':
        return const OrderStatusStyle(
          labelKey: 'orderStatusConfirmed',
          backgroundColor: Color(0xFFE8F5E9),
          textColor: Color(0xFF2E7D32),
        );
      case 'shipped':
        return const OrderStatusStyle(
          labelKey: 'orderStatusShipped',
          backgroundColor: Color(0xFFE3F2FD),
          textColor: Color(0xFF1565C0),
        );
      case 'delivered':
        return const OrderStatusStyle(
          labelKey: 'orderStatusDelivered',
          backgroundColor: Color(0xFFE8F5E9),
          textColor: AppColors.orderSuccess,
        );
      case 'returned':
        return const OrderStatusStyle(
          labelKey: 'orderStatusReturned',
          backgroundColor: Color(0xFFF3E5F5),
          textColor: Color(0xFF7B1FA2),
        );
      case 'processing':
        return const OrderStatusStyle(
          labelKey: 'orderStatusProcessing',
          backgroundColor: Color(0xFFFFF3CD),
          textColor: Color(0xFFE67E22),
        );
      default:
        return OrderStatusStyle(
          labelKey: 'orderStatusUnknown',
          backgroundColor: AppColors.screenBackground,
          textColor: AppColors.textSecondary,
        );
    }
  }
}
