import 'package:zay/app/utils/parser.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class NotificationsCountResponse extends BaseResponse {
  final int unreadCount;

  const NotificationsCountResponse({
    required super.statusCode,
    super.message,
    this.unreadCount = 0,
  });

  factory NotificationsCountResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final Map<String, dynamic>? dataMap =
        data is Map ? Map<String, dynamic>.from(data) : null;

    return NotificationsCountResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      unreadCount: Parser.parseInt(
            json['unread_count'] ??
                json['unreadCount'] ??
                json['count'] ??
                dataMap?['unread_count'] ??
                dataMap?['unreadCount'] ??
                dataMap?['count'],
          ) ??
          0,
    );
  }
}
