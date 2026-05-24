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
    return SignInResponse.fromJson(json);
  }

  @override
  Future<SignInResponse> requestSignUp(SignUpRequest request) async {
    final json = await _authDataSource.requestSignUp(request);
    return SignInResponse.fromJson(json);
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
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestResetPassword(ResetPasswordRequest request) async {
    final json = await _authDataSource.requestResetPassword(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestSignOut() async {
    final json = await _authDataSource.requestSignOut();
    final response = BaseResponse.fromJson(json);
    if (response.isSuccess) {
      await PrefsManager.clear();
    }
    return response;
  }

  @override
  Future<ProfileResponse> requestProfile() async {
    final json = await _authDataSource.requestProfile();
    return ProfileResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestUpdateProfile(UpdateProfileRequest request) async {
    final json = await _authDataSource.requestUpdateProfile(request);
    return BaseResponse.fromJson(json);
  }
}
