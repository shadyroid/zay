import 'package:get/get.dart';
import 'package:zay/data/repositories/notifications_repository_impl.dart';
import 'package:zay/domain/models/requests/notifications_request.dart';
import 'package:zay/domain/models/responses/notifications_response.dart';
import 'package:zay/domain/repositories/notifications_repository.dart';

class NotificationsUseCase {
  final NotificationsRepository _notificationsRepository = Get.put(
    NotificationsRepositoryImpl(),
  );

  Future<NotificationsResponse> requestNotifications(
    NotificationsRequest request,
  ) => _notificationsRepository.requestNotifications(request);
}
