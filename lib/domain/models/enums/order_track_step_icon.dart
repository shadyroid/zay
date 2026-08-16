import 'package:zay/domain/models/enums/order_status.dart';

enum OrderTrackStepIcon {
  pending,
  confirmed,
  preparing,
  shipped,
  delivered,
  returned,
  canceled;

  factory OrderTrackStepIcon.fromString(String? value) {
    return OrderTrackStepIcon.fromStatus(OrderStatus.fromApi(value));
  }

  factory OrderTrackStepIcon.fromStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.accepted:
        return OrderTrackStepIcon.confirmed;
      case OrderStatus.preparing:
        return OrderTrackStepIcon.preparing;
      case OrderStatus.shipped:
        return OrderTrackStepIcon.shipped;
      case OrderStatus.delivered:
        return OrderTrackStepIcon.delivered;
      case OrderStatus.returned:
        return OrderTrackStepIcon.returned;
      case OrderStatus.canceled:
      case OrderStatus.rejected:
        return OrderTrackStepIcon.canceled;
      case OrderStatus.pending:
      case OrderStatus.unknown:
        return OrderTrackStepIcon.pending;
    }
  }
}
