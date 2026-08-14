enum OrderStatus {
  pending,
  processing,
  confirmed,
  shipped,
  delivered,
  returned,
  unknown;

  static OrderStatus fromApi(String? value) {
    switch (value?.toLowerCase().trim()) {
      case 'pending':
        return OrderStatus.pending;
      case 'processing':
        return OrderStatus.processing;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'returned':
        return OrderStatus.returned;
      default:
        return OrderStatus.unknown;
    }
  }

  String get apiValue => switch (this) {
        OrderStatus.pending => 'pending',
        OrderStatus.processing => 'processing',
        OrderStatus.confirmed => 'confirmed',
        OrderStatus.shipped => 'shipped',
        OrderStatus.delivered => 'delivered',
        OrderStatus.returned => 'returned',
        OrderStatus.unknown => 'unknown',
      };

  String get labelKey => switch (this) {
        OrderStatus.pending => 'orderStatusPending',
        OrderStatus.processing => 'orderStatusProcessing',
        OrderStatus.confirmed => 'orderStatusConfirmed',
        OrderStatus.shipped => 'orderStatusShipped',
        OrderStatus.delivered => 'orderStatusDelivered',
        OrderStatus.returned => 'orderStatusReturned',
        OrderStatus.unknown => 'orderStatusUnknown',
      };

  bool get isActive => switch (this) {
        OrderStatus.pending ||
        OrderStatus.processing ||
        OrderStatus.confirmed ||
        OrderStatus.shipped =>
          true,
        _ => false,
      };

  bool get isCompleted => this == OrderStatus.delivered;

  bool get isReturned => this == OrderStatus.returned;
}
