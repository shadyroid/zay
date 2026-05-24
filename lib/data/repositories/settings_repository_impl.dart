import 'package:hedma/data/remote/data_sources/settings_data_source.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/content_response.dart';
import 'package:hedma/domain/repositories/settings_repository.dart';
import 'package:hedma/domain/requests/contact_us_request.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource _settingsDataSource = SettingsDataSource();

  @override
  Future<ContentResponse> requestAboutUs() async {
    final json = await _settingsDataSource.requestAboutUs();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ContentResponse.fromJson(json);
    }
    final page = json['page'] is Map
        ? Map<String, dynamic>.from(json['page'] as Map)
        : null;
    return ContentResponse.fromJson({
      ...json,
      'data': page?['content'] as String? ?? '',
    });
  }

  @override
  Future<ContentResponse> requestTerms() async {
    final json = await _settingsDataSource.requestTerms();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ContentResponse.fromJson(json);
    }
    final page = json['page'] is Map
        ? Map<String, dynamic>.from(json['page'] as Map)
        : null;
    return ContentResponse.fromJson({
      ...json,
      'data': page?['content'] as String? ?? '',
    });
  }

  @override
  Future<ContentResponse> requestPrivacy() async {
    final json = await _settingsDataSource.requestPrivacy();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ContentResponse.fromJson(json);
    }
    final page = json['page'] is Map
        ? Map<String, dynamic>.from(json['page'] as Map)
        : null;
    return ContentResponse.fromJson({
      ...json,
      'data': page?['content'] as String? ?? '',
    });
  }

  @override
  Future<BaseResponse> requestContactUs(ContactUsRequest request) async {
    final json = await _settingsDataSource.requestContactUs(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<void> requestSetLocale(String locale) async {
    await PrefsManager.setLocale(locale);
  }

  @override
  String? getLocale() => PrefsManager.locale;
}
