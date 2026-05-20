import 'package:hedma/domain/models/beans/order_track_step_bean.dart';
import 'package:hedma/domain/models/enums/order_track_step_icon.dart';
import 'package:hedma/domain/models/enums/order_track_step_state.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class OrderTrackResponse extends BaseResponse {
  final String? estimatedDelivery;
  final List<OrderTrackStepBean>? steps;

  const OrderTrackResponse({
    required super.statusCode,
    super.message,
    this.estimatedDelivery,
    this.steps,
  });

  factory OrderTrackResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    String? estimatedDelivery;
    List<OrderTrackStepBean>? steps;

    if (data is Map<String, dynamic>) {
      estimatedDelivery = data['estimatedDelivery'] as String?;
      final stepsList = data['steps'] as List<dynamic>?;
      steps = stepsList
          ?.map((e) => OrderTrackStepBean.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (data is List) {
      steps = data.asMap().entries.map((entry) {
        final index = entry.key;
        final key = entry.value.toString();
        return OrderTrackStepBean(
          titleKey: key,
          subtitleKey: '',
          timestamp: '',
          state: index <= 1
              ? OrderTrackStepState.completed
              : OrderTrackStepState.upcoming,
          icon: OrderTrackStepIcon.pending,
        );
      }).toList();
    }

    return OrderTrackResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      estimatedDelivery: estimatedDelivery,
      steps: steps,
    );
  }
}
