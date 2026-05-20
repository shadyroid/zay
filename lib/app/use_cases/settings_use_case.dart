import 'package:get/get.dart';
import 'package:hedma/data/repositories/settings_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/content_response.dart';
import 'package:hedma/domain/repositories/settings_repository.dart';

class SettingsUseCase {
  final SettingsRepository _settingsRepository =
      Get.put(SettingsRepositoryImpl());

  Future<ContentResponse> requestAboutUs() =>
      _settingsRepository.requestAboutUs();

  Future<ContentResponse> requestTerms() => _settingsRepository.requestTerms();

  Future<ContentResponse> requestPrivacy() =>
      _settingsRepository.requestPrivacy();

  Future<BaseResponse> requestSendMessage({
    required String name,
    required String email,
    required String message,
  }) =>
      _settingsRepository.requestSendMessage(
        name: name,
        email: email,
        message: message,
      );
}
