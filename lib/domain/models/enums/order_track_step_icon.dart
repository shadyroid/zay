import 'package:zay/domain/models/enums/order_status.dart';

enum OrderTrackStepIcon {
  pending,
  confirmed,
  shipped,
  delivered,
  returned;

  factory OrderTrackStepIcon.fromString(String? value) {
    return OrderTrackStepIcon.fromStatus(OrderStatus.fromApi(value));
  }

  factory OrderTrackStepIcon.fromStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.shipped:
        return OrderTrackStepIcon.shipped;
      case OrderStatus.delivered:
        return OrderTrackStepIcon.delivered;
      case OrderStatus.returned:
        return OrderTrackStepIcon.returned;
      case OrderStatus.pending:
      case OrderStatus.accepted:
      case OrderStatus.preparing:
      case OrderStatus.canceled:
      case OrderStatus.rejected:
      case OrderStatus.unknown:
        return OrderTrackStepIcon.pending;
    }
  }
}
