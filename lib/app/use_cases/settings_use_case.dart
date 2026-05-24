import 'package:get/get.dart';
import 'package:hedma/data/repositories/settings_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/content_response.dart';
import 'package:hedma/domain/repositories/settings_repository.dart';
import 'package:hedma/domain/requests/contact_us_request.dart';

class SettingsUseCase {
  final SettingsRepository _settingsRepository =
      Get.put(SettingsRepositoryImpl());

  Future<ContentResponse> requestAboutUs() =>
      _settingsRepository.requestAboutUs();

  Future<ContentResponse> requestTerms() => _settingsRepository.requestTerms();

  Future<ContentResponse> requestPrivacy() =>
      _settingsRepository.requestPrivacy();

  Future<BaseResponse> requestContactUs(ContactUsRequest request) =>
      _settingsRepository.requestContactUs(request);

  Future<void> requestSetLocale(String locale) =>
      _settingsRepository.requestSetLocale(locale);

  String? getLocale() => _settingsRepository.getLocale();
}
