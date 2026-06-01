import 'package:get/get.dart';
import 'package:hedma/data/repositories/auth_repository_impl.dart';
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
