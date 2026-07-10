import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/content_response.dart';
import 'package:zay/domain/requests/contact_us_request.dart';

abstract class SettingsRepository {
  Future<ContentResponse> requestAboutUs();

  Future<ContentResponse> requestTerms();

  Future<ContentResponse> requestPrivacy();

  Future<BaseResponse> requestContactUs(ContactUsRequest request);

  Future<void> requestSetLocale(String locale);

  String? getLocale();
}
