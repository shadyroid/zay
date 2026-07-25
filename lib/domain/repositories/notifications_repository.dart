import 'package:zay/domain/models/requests/notifications_request.dart';
import 'package:zay/domain/models/requests/read_notification_request.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/notifications_count_response.dart';
import 'package:zay/domain/models/responses/notifications_response.dart';

abstract class NotificationsRepository {
  Future<NotificationsResponse> requestNotifications(
    NotificationsRequest request,
  );

  Future<NotificationsCountResponse> requestNotificationsCount();

  Future<BaseResponse> requestReadNotifications();

  Future<BaseResponse> requestReadNotification(ReadNotificationRequest request);
}
