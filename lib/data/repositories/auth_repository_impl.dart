import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/data/remote/data_sources/auth_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/profile_response.dart';
import 'package:hedma/domain/models/responses/sign_in_response.dart';
import 'package:hedma/domain/repositories/auth_repository.dart';
import 'package:hedma/domain/requests/forget_password_request.dart';
import 'package:hedma/domain/requests/reset_password_request.dart';
import 'package:hedma/domain/requests/sign_in_request.dart';
import 'package:hedma/domain/requests/sign_up_request.dart';
import 'package:hedma/domain/requests/update_profile_request.dart';
import 'package:hedma/domain/requests/verification_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource = AuthDataSource();

  @override
  Future<SignInResponse> requestSignIn(SignInRequest request) async {
    final json = await _authDataSource.requestSignIn(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return SignInResponse.fromJson(json);
    }
    final response = SignInResponse.fromJson({
      ...json,
      'data': {'token': json['token']},
    });
    final token = response.data?.token;
    if (response.isSuccess && token != null && token.isNotEmpty) {
      await PrefsManager.setToken(token);
    }
    return response;
  }

  @override
  Future<SignInResponse> requestSignUp(SignUpRequest request) async {
    final json = await _authDataSource.requestSignUp(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return SignInResponse.fromJson(json);
    }
    final response = SignInResponse.fromJson({
      ...json,
      'data': {'token': json['token']},
    });
    final token = response.data?.token;
    if (response.isSuccess && token != null && token.isNotEmpty) {
      await PrefsManager.setToken(token);
    }
    return response;
  }

  @override
  Future<BaseResponse> requestForgetPassword(
    ForgetPasswordRequest request,
  ) async {
    final json = await _authDataSource.requestForgetPassword(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestVerification(VerificationRequest request) async {
    final json = await _authDataSource.requestVerification(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestResetPassword(ResetPasswordRequest request) async {
    final json = await _authDataSource.requestResetPassword(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestSignOut() async {
    final json = await _authDataSource.requestSignOut();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    final response = BaseResponse.fromJson(json);
    if (response.isSuccess) {
      await PrefsManager.clear();
    }
    return response;
  }

  @override
  Future<ProfileResponse> requestProfile() async {
    final json = await _authDataSource.requestProfile();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ProfileResponse.fromJson(json);
    }
    return ProfileResponse.fromJson({
      ...json,
      'data': json['user'] is Map
          ? Map<String, dynamic>.from(json['user'] as Map)
          : null,
    });
  }

  @override
  Future<BaseResponse> requestUpdateProfile(UpdateProfileRequest request) async {
    final json = await _authDataSource.requestUpdateProfile(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestClearAccount() async {
    await PrefsManager.clear();
    return const BaseResponse(statusCode: 200);
  }
}
