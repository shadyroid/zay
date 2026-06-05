import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/data/remote/data_sources/auth_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/profile_response.dart';
import 'package:hedma/domain/repositories/auth_repository.dart';
import 'package:hedma/domain/requests/change_password_request.dart';
import 'package:hedma/domain/requests/forget_password_request.dart';
import 'package:hedma/domain/requests/resend_verification_code_request.dart';
import 'package:hedma/domain/requests/reset_password_request.dart';
import 'package:hedma/domain/requests/sign_in_request.dart';
import 'package:hedma/domain/requests/sign_up_request.dart';
import 'package:hedma/domain/requests/update_profile_request.dart';
import 'package:hedma/domain/requests/verification_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource = AuthDataSource();

  @override
  Future<BaseResponse> requestSignIn(SignInRequest request) async {
    final json = await _authDataSource.requestSignIn(request);
    if (json['statusCode'] == 200) {
      await PrefsManager.setToken(json['token']);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestSignUp(SignUpRequest request) async {
    final json = await _authDataSource.requestSignUp(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestForgetPassword(
    ForgetPasswordRequest request,
  ) async {
    final json = await _authDataSource.requestForgetPassword(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestVerification(VerificationRequest request) async {
    final json = await _authDataSource.requestVerification(request);
    if (json['statusCode'] == 200) {
      await PrefsManager.setToken(json['token']);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestResendVerificationCode(
    ResendVerificationCodeRequest request,
  ) async {
    final json = await _authDataSource.requestResendVerificationCode(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestResetPassword(
    ResetPasswordRequest request,
  ) async {
    final json = await _authDataSource.requestResetPassword(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestSignOut() async {
    final json = await _authDataSource.requestSignOut();
    if (json['statusCode'] == 200) {
      await PrefsManager.clear();
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<ProfileResponse> requestProfile() async {
    var json = await _authDataSource.requestProfile();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['user'],
    };
    return ProfileResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestUpdateProfile(
    UpdateProfileRequest request,
  ) async {
    final json = await _authDataSource.requestUpdateProfile(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestChangePassword(
    ChangePasswordRequest request,
  ) async {
    final json = await _authDataSource.requestChangePassword(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestDeleteAccount() async {
    final json = await _authDataSource.requestDeleteAccount();
    if (json['statusCode'] == 200) {
      await PrefsManager.clear();
    }
    return BaseResponse.fromJson(json);
  }
}
