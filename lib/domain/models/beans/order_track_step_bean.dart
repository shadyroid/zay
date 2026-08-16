import 'package:zay/domain/models/enums/order_status.dart';
import 'package:zay/domain/models/enums/order_track_step_icon.dart';
import 'package:zay/domain/models/enums/order_track_step_state.dart';

class OrderTrackStepBean {
  const OrderTrackStepBean({
    required this.toStatus,
    this.fromStatus,
    this.note,
    this.createdAt,
    this.changedBy,
    required this.state,
    required this.icon,
  });

  final OrderStatus toStatus;
  final OrderStatus? fromStatus;
  final String? note;
  final String? createdAt;
  final String? changedBy;
  final OrderTrackStepState state;
  final OrderTrackStepIcon icon;

  bool get isCompleted => state == OrderTrackStepState.completed;

  bool get isActive => state == OrderTrackStepState.active;

  String get titleKey => toStatus.labelKey;

  String? get trimmedNote {
    final value = note?.trim();
    if (value == null || value.isEmpty) return null;
    return value;
  }

  String? get trimmedChangedBy {
    final value = changedBy?.trim();
    if (value == null || value.isEmpty) return null;
    return value;
  }

  String? get descriptionKey => switch (toStatus) {
        OrderStatus.pending => 'trackStepPendingDesc',
        OrderStatus.accepted => 'trackStepConfirmedDesc',
        OrderStatus.preparing => 'trackStepPreparingDesc',
        OrderStatus.shipped => 'trackStepShippedDesc',
        OrderStatus.delivered => 'trackStepDeliveredDesc',
        OrderStatus.returned => 'trackStepReturnedDesc',
        OrderStatus.canceled => 'trackStepCanceledDesc',
        OrderStatus.rejected => 'trackStepRejectedDesc',
        OrderStatus.unknown => null,
      };

  factory OrderTrackStepBean.fromJson(
    Map<String, dynamic> json, {
    OrderTrackStepState state = OrderTrackStepState.completed,
  }) {
    final toStatus = OrderStatus.fromApi(json['to_status']?.toString());
    final fromRaw = json['from_status']?.toString();

    return OrderTrackStepBean(
      toStatus: toStatus,
      fromStatus: fromRaw == null || fromRaw.trim().isEmpty
          ? null
          : OrderStatus.fromApi(fromRaw),
      note: json['note'] as String?,
      createdAt: json['created_at'] as String?,
      changedBy: json['changed_by'] as String?,
      state: state,
      icon: OrderTrackStepIcon.fromStatus(toStatus),
    );
  }

  static List<OrderTrackStepBean> parseList(
    List<dynamic>? raw, {
    OrderStatus? currentStatus,
  }) {
    if (raw == null) return const [];

    final entries = <Map<String, dynamic>>[];
    for (final entry in raw) {
      if (entry is Map) {
        entries.add(Map<String, dynamic>.from(entry));
      }
    }
    if (entries.isEmpty) return const [];

    final isTerminal = currentStatus == OrderStatus.delivered ||
        currentStatus == OrderStatus.returned ||
        currentStatus == OrderStatus.canceled ||
        currentStatus == OrderStatus.rejected;

    return [
      for (var i = 0; i < entries.length; i++)
        OrderTrackStepBean.fromJson(
          entries[i],
          state: i == entries.length - 1 && !isTerminal
              ? OrderTrackStepState.active
              : OrderTrackStepState.completed,
        ),
    ];
  }
}
