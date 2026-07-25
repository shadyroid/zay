import 'package:zay/data/remote/data_sources/notifications_data_source.dart';
import 'package:zay/domain/models/requests/notifications_request.dart';
import 'package:zay/domain/models/requests/read_notification_request.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/notifications_count_response.dart';
import 'package:zay/domain/models/responses/notifications_response.dart';
import 'package:zay/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsDataSource _notificationsDataSource =
      NotificationsDataSource();

  @override
  Future<NotificationsResponse> requestNotifications(
    NotificationsRequest request,
  ) async {
    var json = await _notificationsDataSource.requestNotifications(request);

    final notifications = json['notifications'];
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": notifications is Map ? notifications['data'] : notifications,
      "unreadCount": json['unread_count'],
    };

    return NotificationsResponse.fromJson(json);
  }

  @override
  Future<NotificationsCountResponse> requestNotificationsCount() async {
    final json = await _notificationsDataSource.requestNotificationsCount();
    return NotificationsCountResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestReadNotifications() async {
    final json = await _notificationsDataSource.requestReadNotifications();
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestReadNotification(
    ReadNotificationRequest request,
  ) async {
    final json =
        await _notificationsDataSource.requestReadNotification(request);
    return BaseResponse.fromJson(json);
  }
}
