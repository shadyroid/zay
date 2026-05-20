import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/content_response.dart';

abstract class SettingsRepository {
  Future<ContentResponse> requestAboutUs();

  Future<ContentResponse> requestTerms();

  Future<BaseResponse> requestSendMessage({
    required String name,
    required String email,
    required String message,
  });
}
