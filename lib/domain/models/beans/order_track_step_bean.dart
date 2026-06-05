import 'package:hedma/domain/models/enums/order_track_step_icon.dart';
import 'package:hedma/domain/models/enums/order_track_step_state.dart';

class OrderTrackStepBean {
  const OrderTrackStepBean({
    required this.titleKey,
    required this.subtitleKey,
    required this.timestamp,
    required this.state,
    required this.icon,
  });

  final String titleKey;
  final String subtitleKey;
  final String timestamp;
  final OrderTrackStepState state;
  final OrderTrackStepIcon icon;

  bool get isCompleted => state == OrderTrackStepState.completed;

  bool get isActive => state == OrderTrackStepState.active;

  factory OrderTrackStepBean.fromJson(Map<String, dynamic> json) {
    return OrderTrackStepBean(
      titleKey: json['titleKey'],
      subtitleKey: json['subtitleKey'],
      timestamp: json['timestamp'],
      state: OrderTrackStepState.fromString(json['state'] as String?),
      icon: OrderTrackStepIcon.fromString(json['icon'] as String?),
    );
  }
}
