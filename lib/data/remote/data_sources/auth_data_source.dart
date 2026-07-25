import 'package:dio/dio.dart' as dio_multipart show FormData, MultipartFile;
import 'package:get/get.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/app/utils/notifications_util.dart';
import 'package:zay/data/remote/dio_client.dart';
import 'package:zay/domain/models/requests/change_password_request.dart';
import 'package:zay/domain/models/requests/delete_account_request.dart';
import 'package:zay/domain/models/requests/forget_password_request.dart';
import 'package:zay/domain/models/requests/resend_verification_code_request.dart';
import 'package:zay/domain/models/requests/reset_password_request.dart';
import 'package:zay/domain/models/requests/sign_in_request.dart';
import 'package:zay/domain/models/requests/sign_up_request.dart';
import 'package:zay/domain/models/requests/update_profile_request.dart';
import 'package:zay/domain/models/requests/verification_request.dart';

class AuthDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestSignIn(SignInRequest request) async {
    final response = await _dioClient.post(
      Constants.signInPath,
      data: {
        'email': request.email,
        'password': request.password,
        'fcm_token': await NotificationsUtil.getToken() ?? '',
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestSignUp(SignUpRequest request) async {
    final response = await _dioClient.post(
      Constants.signUpPath,
      data: {
        'name': request.name,
        'email': request.email,
        'phone': request.phone ?? '',
        'password': request.password,
        'password_confirmation': request.passwordConfirmation,
        'height': request.height,
        'weight': request.weight,
        'fcm_token': await NotificationsUtil.getToken() ?? '',
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestForgetPassword(
    ForgetPasswordRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.forgetPasswordPath,
      data: {'email': request.email},
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestVerification(
    VerificationRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.verificationPath,
      data: {
        'email': request.email,
        'otp': request.otp,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestResendVerificationCode(
    ResendVerificationCodeRequest request,
  ) async {
    if (request.isPasswordReset) {
      return requestForgetPassword(
        ForgetPasswordRequest(email: request.email),
      );
    }

    final response = await _dioClient.post(
      Constants.resendVerificationPath,
      data: {'email': request.email},
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestResetPassword(
    ResetPasswordRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.resetPasswordPath,
      data: {
        'email': request.email,
        'otp': request.otp,
        'password': request.password,
        'password_confirmation': request.passwordConfirmation,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestSignOut() async {
    final response = await _dioClient.post(Constants.signOutPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestProfile() async {
    final response = await _dioClient.get(Constants.profilePath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestUpdateProfile(
    UpdateProfileRequest request,
  ) async {
    final fields = <String, dynamic>{
      'name': request.name,
      if(request.phone!=null)'phone': request.phone,
      if(request.height!=null)'height': request.height,
      if(request.weight!=null)'weight': request.weight,
    };

    final avatarPath = request.avatarPath;
    if (avatarPath != null && avatarPath.isNotEmpty) {
      fields['avatar'] = await dio_multipart.MultipartFile.fromFile(
        avatarPath,
        filename: avatarPath.split('/').last,
      );
    }

    final response = await _dioClient.post(
      Constants.profilePath,
      data: dio_multipart.FormData.fromMap(fields),
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestChangePassword(
    ChangePasswordRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.changePasswordPath,
      data: {
        'current_password': request.currentPassword,
        'password': request.password,
        'password_confirmation': request.passwordConfirmation,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestDeleteAccount(
    DeleteAccountRequest request,
  ) async {
    final response = await _dioClient.post(
      Constants.deleteAccountPath,
      data: {
        'password': request.password,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
