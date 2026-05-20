import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';

class SettingsDataSource {
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestAboutUs() => _remote.post(
        Constants.aboutUsPath,
        dummyJson: DummyJson.aboutUs(),
      );

  Future<Map<String, dynamic>> requestTerms() => _remote.post(
        Constants.termsPath,
        dummyJson: DummyJson.terms(),
      );

  Future<Map<String, dynamic>> requestSendMessage({
    required String name,
    required String email,
    required String message,
  }) =>
      _remote.post(
        Constants.contactUsPath,
        variables: {'name': name, 'email': email, 'message': message},
        dummyJson: DummyJson.sendMessage(),
      );
}
