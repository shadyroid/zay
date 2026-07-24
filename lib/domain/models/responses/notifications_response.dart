import 'package:zay/domain/models/beans/notification_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class NotificationsResponse extends BaseResponse {
  final List<NotificationBean>? data;
  final int? unreadCount;

  const NotificationsResponse({
    required super.statusCode,
    super.message,
    this.data,
    this.unreadCount,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return NotificationsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: list
          ?.map((e) => NotificationBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      unreadCount: json['unreadCount'],
    );
  }
}
