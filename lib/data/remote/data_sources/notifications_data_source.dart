import 'package:get/get.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/remote/dio_client.dart';
import 'package:zay/domain/models/requests/notifications_request.dart';
import 'package:zay/domain/models/requests/read_notification_request.dart';

class NotificationsDataSource {
  final DioClient _dioClient = Get.put(DioClient());
  Future<Map<String, dynamic>> requestNotifications(
    NotificationsRequest request,
  ) async {
    final response = await _dioClient.get(
      Constants.notificationsPath,
      queryParameters: request.toJson(),
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestNotificationsCount() async {
    final response = await _dioClient.get(
      Constants.notificationsUnreadCountPath,
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestReadNotifications() async {
    final response = await _dioClient.post(
      Constants.notificationsMarkAllReadPath,
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestReadNotification(
    ReadNotificationRequest request,
  ) async {
    final response = await _dioClient.post(
      '${Constants.notificationsReadPath}/${request.notificationId}/read',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
