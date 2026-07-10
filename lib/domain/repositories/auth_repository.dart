import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/profile_response.dart';
import 'package:zay/domain/requests/change_password_request.dart';
import 'package:zay/domain/requests/forget_password_request.dart';
import 'package:zay/domain/requests/resend_verification_code_request.dart';
import 'package:zay/domain/requests/reset_password_request.dart';
import 'package:zay/domain/requests/sign_in_request.dart';
import 'package:zay/domain/requests/sign_up_request.dart';
import 'package:zay/domain/requests/update_profile_request.dart';
import 'package:zay/domain/requests/verification_request.dart';

abstract class AuthRepository {
  Future<BaseResponse> requestSignIn(SignInRequest request);

  Future<BaseResponse> requestSignUp(SignUpRequest request);

  Future<BaseResponse> requestForgetPassword(ForgetPasswordRequest request);

  Future<BaseResponse> requestVerification(VerificationRequest request);

  Future<BaseResponse> requestResendVerificationCode(
    ResendVerificationCodeRequest request,
  );

  Future<BaseResponse> requestResetPassword(ResetPasswordRequest request);

  Future<BaseResponse> requestSignOut();

  Future<ProfileResponse> requestProfile();

  Future<BaseResponse> requestUpdateProfile(UpdateProfileRequest request);

  Future<BaseResponse> requestChangePassword(ChangePasswordRequest request);

  Future<BaseResponse> requestDeleteAccount();
}
