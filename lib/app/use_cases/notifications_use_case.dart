import 'package:get/get.dart';
import 'package:zay/data/repositories/notifications_repository_impl.dart';
import 'package:zay/domain/models/requests/notifications_request.dart';
import 'package:zay/domain/models/requests/read_notification_request.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/notifications_count_response.dart';
import 'package:zay/domain/models/responses/notifications_response.dart';
import 'package:zay/domain/repositories/notifications_repository.dart';

class NotificationsUseCase {
  final NotificationsRepository _notificationsRepository = Get.put(
    NotificationsRepositoryImpl(),
  );

  Future<NotificationsResponse> requestNotifications(
    NotificationsRequest request,
  ) =>
      _notificationsRepository.requestNotifications(request);

  Future<NotificationsCountResponse> requestNotificationsCount() =>
      _notificationsRepository.requestNotificationsCount();

  Future<BaseResponse> requestReadNotifications() =>
      _notificationsRepository.requestReadNotifications();

  Future<BaseResponse> requestReadNotification(
    ReadNotificationRequest request,
  ) =>
      _notificationsRepository.requestReadNotification(request);
}
