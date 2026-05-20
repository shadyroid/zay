import 'package:hedma/data/remote/data_sources/settings_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/content_response.dart';
import 'package:hedma/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource _settingsDataSource = SettingsDataSource();

  @override
  Future<ContentResponse> requestAboutUs() async {
    final json = await _settingsDataSource.requestAboutUs();
    return ContentResponse.fromJson(json);
  }

  @override
  Future<ContentResponse> requestTerms() async {
    final json = await _settingsDataSource.requestTerms();
    return ContentResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestSendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    final json = await _settingsDataSource.requestSendMessage(
      name: name,
      email: email,
      message: message,
    );
    return BaseResponse.fromJson(json);
  }
}
