import 'package:get/get.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dio_client.dart';
import 'package:hedma/domain/requests/contact_us_request.dart';

class SettingsDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestAboutUs() async {
    final response = await _dioClient.get(Constants.aboutUsPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestTerms() async {
    final response = await _dioClient.get(Constants.termsPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestPrivacy() async {
    final response = await _dioClient.get(Constants.privacyPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestContactUs(
    ContactUsRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.contactUsPath,
      data: {
        'name': request.name,
        'email': request.email,
        'phone': request.phone,
        'subject': request.subject,
        'message': request.message,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
