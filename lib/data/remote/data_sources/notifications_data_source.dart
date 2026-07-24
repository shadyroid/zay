import 'package:get/get.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/remote/dio_client.dart';
import 'package:zay/domain/models/requests/notifications_request.dart';

class NotificationsDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestNotifications(
    NotificationsRequest request,
  ) async {
    final response = await _dioClient.get(
      Constants.notificationsPath,
      queryParameters: request.toJson(),
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
