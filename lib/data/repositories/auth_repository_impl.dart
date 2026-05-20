import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/data/remote/data_sources/auth_data_source.dart';
import 'package:hedma/domain/models/beans/user_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/profile_response.dart';
import 'package:hedma/domain/models/responses/sign_in_response.dart';
import 'package:hedma/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource = AuthDataSource();

  @override
  Future<SignInResponse> requestSignIn({
    required String email,
    required String password,
  }) async {
    final json = await _authDataSource.requestSignIn(
      email: email,
      password: password,
    );
    return SignInResponse.fromJson(json);
  }

  @override
  Future<SignInResponse> requestSignUp({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? height,
    String? weight,
  }) async {
    final json = await _authDataSource.requestSignUp(
      name: name,
      email: email,
      password: password,
      phone: phone,
      height: height,
      weight: weight,
    );
    return SignInResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestForgetPassword({required String email}) async {
    final json = await _authDataSource.requestForgetPassword(email: email);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestVerification({
    required String email,
    required String code,
  }) async {
    final json = await _authDataSource.requestVerification(
      email: email,
      code: code,
    );
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestResetPassword({
    required String email,
    required String password,
    required String code,
  }) async {
    final json = await _authDataSource.requestResetPassword(
      email: email,
      password: password,
      code: code,
    );
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestLogout() async {
    await _authDataSource.requestLogout();
    await PrefsManager.clear();
    return const BaseResponse(statusCode: 200);
  }

  @override
  Future<ProfileResponse> requestProfile() async {
    final json = await _authDataSource.requestProfile();
    return ProfileResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestUpdateProfile({
    required UserBean profile,
  }) async {
    final json = await _authDataSource.requestUpdateProfile(profile: profile);
    return BaseResponse.fromJson(json);
  }
}
