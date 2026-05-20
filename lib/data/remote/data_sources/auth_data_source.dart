import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';
import 'package:hedma/domain/models/beans/user_bean.dart';

class AuthDataSource {
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestSignIn({
    required String email,
    required String password,
  }) =>
      _remote.post(
        Constants.signInPath,
        variables: {'email': email, 'password': password},
        dummyJson: DummyJson.signIn(),
      );

  Future<Map<String, dynamic>> requestSignUp({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? height,
    String? weight,
  }) {
    final variables = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
    if (phone != null) variables['phone'] = phone;
    if (height != null) variables['height'] = height;
    if (weight != null) variables['weight'] = weight;

    return _remote.post(
      Constants.signUpPath,
      variables: variables,
      dummyJson: DummyJson.signUp(),
    );
  }

  Future<Map<String, dynamic>> requestForgetPassword({
    required String email,
  }) =>
      _remote.post(
        Constants.forgetPasswordPath,
        variables: {'email': email},
        dummyJson: DummyJson.forgetPassword(),
      );

  Future<Map<String, dynamic>> requestVerification({
    required String email,
    required String code,
  }) =>
      _remote.post(
        Constants.verificationPath,
        variables: {'email': email, 'code': code},
        dummyJson: DummyJson.verification(),
      );

  Future<Map<String, dynamic>> requestResetPassword({
    required String email,
    required String password,
    required String code,
  }) =>
      _remote.post(
        Constants.resetPasswordPath,
        variables: {
          'email': email,
          'password': password,
          'code': code,
        },
        dummyJson: DummyJson.resetPassword(),
      );

  Future<Map<String, dynamic>> requestLogout() => _remote.post(
        Constants.logoutPath,
        dummyJson: DummyJson.logout(),
      );

  Future<Map<String, dynamic>> requestProfile() => _remote.post(
        Constants.profilePath,
        dummyJson: DummyJson.profile(),
      );

  Future<Map<String, dynamic>> requestUpdateProfile({
    required UserBean profile,
  }) =>
      _remote.post(
        Constants.updateProfilePath,
        variables: profile.toJson(),
        dummyJson: DummyJson.updateProfile(),
      );
}
