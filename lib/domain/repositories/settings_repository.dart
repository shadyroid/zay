import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/content_response.dart';
import 'package:hedma/domain/requests/contact_us_request.dart';

abstract class SettingsRepository {
  Future<ContentResponse> requestAboutUs();

  Future<ContentResponse> requestTerms();

  Future<ContentResponse> requestPrivacy();

  Future<BaseResponse> requestContactUs(ContactUsRequest request);

  Future<void> requestSetLocale(String locale);

  String? getLocale();
}
