import 'package:get/get.dart';
import 'package:zay/data/repositories/auth_repository_impl.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/profile_response.dart';
import 'package:zay/domain/repositories/auth_repository.dart';
import 'package:zay/domain/models/requests/change_password_request.dart';
import 'package:zay/domain/models/requests/forget_password_request.dart';
import 'package:zay/domain/models/requests/resend_verification_code_request.dart';
import 'package:zay/domain/models/requests/reset_password_request.dart';
import 'package:zay/domain/models/requests/sign_in_request.dart';
import 'package:zay/domain/models/requests/sign_up_request.dart';
import 'package:zay/domain/models/requests/update_profile_request.dart';
import 'package:zay/domain/models/requests/verification_request.dart';

class AuthUseCase {
  final AuthRepository _authRepository = Get.put(AuthRepositoryImpl());

  Future<BaseResponse> requestSignIn(SignInRequest request) =>
      _authRepository.requestSignIn(request);

  Future<BaseResponse> requestSignUp(SignUpRequest request) =>
      _authRepository.requestSignUp(request);

  Future<BaseResponse> requestForgetPassword(ForgetPasswordRequest request) =>
      _authRepository.requestForgetPassword(request);

  Future<BaseResponse> requestVerification(VerificationRequest request) =>
      _authRepository.requestVerification(request);

  Future<BaseResponse> requestResendVerificationCode(
    ResendVerificationCodeRequest request,
  ) =>
      _authRepository.requestResendVerificationCode(request);

  Future<BaseResponse> requestResetPassword(ResetPasswordRequest request) =>
      _authRepository.requestResetPassword(request);

  Future<BaseResponse> requestSignOut() => _authRepository.requestSignOut();

  Future<ProfileResponse> requestProfile() => _authRepository.requestProfile();

  Future<BaseResponse> requestUpdateProfile(UpdateProfileRequest request) =>
      _authRepository.requestUpdateProfile(request);

  Future<BaseResponse> requestChangePassword(ChangePasswordRequest request) =>
      _authRepository.requestChangePassword(request);

  Future<BaseResponse> requestDeleteAccount() =>
      _authRepository.requestDeleteAccount();
}
