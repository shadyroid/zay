import 'package:zay/domain/models/requests/notifications_request.dart';
import 'package:zay/domain/models/responses/notifications_response.dart';

abstract class NotificationsRepository {
  Future<NotificationsResponse> requestNotifications(
    NotificationsRequest request,
  );
}
