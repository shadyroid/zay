enum OrderStatus {
  pending,
  accepted,
  preparing,
  shipped,
  delivered,
  returned,
  canceled,
  rejected,
  unknown;

  static OrderStatus fromApi(String? value) {
    switch (value?.toLowerCase().trim()) {
      case 'pending':
        return OrderStatus.pending;
      case 'preparing':
      case 'processing':
        return OrderStatus.preparing;
      case 'accepted':
      case 'confirmed':
        return OrderStatus.accepted;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'returned':
        return OrderStatus.returned;
      case 'canceled':
      case 'cancelled':
        return OrderStatus.canceled;
      case 'rejected':
        return OrderStatus.rejected;
      default:
        return OrderStatus.unknown;
    }
  }

  String get apiValue => switch (this) {
        OrderStatus.pending => 'pending',
        OrderStatus.accepted => 'accepted',
        OrderStatus.preparing => 'preparing',
        OrderStatus.shipped => 'shipped',
        OrderStatus.delivered => 'delivered',
        OrderStatus.returned => 'returned',
        OrderStatus.canceled => 'canceled',
        OrderStatus.rejected => 'rejected',
        OrderStatus.unknown => 'unknown',
      };

  String get labelKey => switch (this) {
        OrderStatus.pending => 'orderStatusPending',
        OrderStatus.accepted => 'orderStatusAccepted',
        OrderStatus.preparing => 'orderStatusPreparing',
        OrderStatus.shipped => 'orderStatusShipped',
        OrderStatus.delivered => 'orderStatusDelivered',
        OrderStatus.returned => 'orderStatusReturned',
        OrderStatus.canceled => 'orderStatusCanceled',
        OrderStatus.rejected => 'orderStatusRejected',
        OrderStatus.unknown => 'orderStatusUnknown',
      };

  bool get isActive => switch (this) {
        OrderStatus.pending ||
        OrderStatus.accepted ||
        OrderStatus.preparing ||
        OrderStatus.shipped =>
          true,
        _ => false,
      };

  bool get isCompleted => this == OrderStatus.delivered;

  bool get isReturned => this == OrderStatus.returned;
}
