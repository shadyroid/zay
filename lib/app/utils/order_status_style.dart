import 'package:flutter/material.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/enums/order_status.dart';

class OrderStatusStyle {
  const OrderStatusStyle({
    required this.labelKey,
    required this.backgroundColor,
    required this.textColor,
  });

  final String labelKey;
  final Color backgroundColor;
  final Color textColor;

  static OrderStatusStyle forStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return OrderStatusStyle(
          labelKey: status.labelKey,
          backgroundColor: const Color(0xFFFFF3CD),
          textColor: const Color(0xFFE67E22),
        );
      case OrderStatus.confirmed:
        return OrderStatusStyle(
          labelKey: status.labelKey,
          backgroundColor: const Color(0xFFE8F5E9),
          textColor: const Color(0xFF2E7D32),
        );
      case OrderStatus.shipped:
        return OrderStatusStyle(
          labelKey: status.labelKey,
          backgroundColor: const Color(0xFFE3F2FD),
          textColor: const Color(0xFF1565C0),
        );
      case OrderStatus.delivered:
        return OrderStatusStyle(
          labelKey: status.labelKey,
          backgroundColor: const Color(0xFFE8F5E9),
          textColor: AppColors.orderSuccess,
        );
      case OrderStatus.returned:
        return OrderStatusStyle(
          labelKey: status.labelKey,
          backgroundColor: const Color(0xFFF3E5F5),
          textColor: const Color(0xFF7B1FA2),
        );
      case OrderStatus.processing:
        return OrderStatusStyle(
          labelKey: status.labelKey,
          backgroundColor: const Color(0xFFFFF3CD),
          textColor: const Color(0xFFE67E22),
        );
      case OrderStatus.unknown:
        return OrderStatusStyle(
          labelKey: status.labelKey,
          backgroundColor: AppColors.screenBackground,
          textColor: AppColors.textSecondary,
        );
    }
  }
}
