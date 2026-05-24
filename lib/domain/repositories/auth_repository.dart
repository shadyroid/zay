import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/profile_response.dart';
import 'package:hedma/domain/models/responses/sign_in_response.dart';
import 'package:hedma/domain/requests/forget_password_request.dart';
import 'package:hedma/domain/requests/reset_password_request.dart';
import 'package:hedma/domain/requests/sign_in_request.dart';
import 'package:hedma/domain/requests/sign_up_request.dart';
import 'package:hedma/domain/requests/update_profile_request.dart';
import 'package:hedma/domain/requests/verification_request.dart';

abstract class AuthRepository {
  Future<SignInResponse> requestSignIn(SignInRequest request);

  Future<SignInResponse> requestSignUp(SignUpRequest request);

  Future<BaseResponse> requestForgetPassword(ForgetPasswordRequest request);

  Future<BaseResponse> requestVerification(VerificationRequest request);

  Future<BaseResponse> requestResetPassword(ResetPasswordRequest request);

  Future<BaseResponse> requestSignOut();

  Future<ProfileResponse> requestProfile();

  Future<BaseResponse> requestUpdateProfile(UpdateProfileRequest request);

  Future<BaseResponse> requestClearAccount();
}
