import 'package:zay/data/remote/data_sources/notifications_data_source.dart';
import 'package:zay/domain/models/requests/notifications_request.dart';
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
}
