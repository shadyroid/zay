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
    var json = await _settingsDataSource.requestAboutUs();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['page']?['content'],
    };
    return ContentResponse.fromJson(json);
  }

  @override
  Future<ContentResponse> requestTerms() async {
    var json = await _settingsDataSource.requestTerms();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['page']?['content'],
    };
    return ContentResponse.fromJson(json);
  }

  @override
  Future<ContentResponse> requestPrivacy() async {
    var json = await _settingsDataSource.requestPrivacy();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['page']?['content'],
    };
    return ContentResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestContactUs(ContactUsRequest request) async {
    final json = await _settingsDataSource.requestContactUs(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<void> requestSetLocale(String locale) async {
    await PrefsManager.setLocale(locale);
  }

  @override
  String? getLocale() => PrefsManager.locale;
}
