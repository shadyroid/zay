import 'package:hedma/domain/models/beans/user_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/profile_response.dart';
import 'package:hedma/domain/models/responses/sign_in_response.dart';

abstract class AuthRepository {
  Future<SignInResponse> requestSignIn({
    required String email,
    required String password,
  });

  Future<SignInResponse> requestSignUp({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? height,
    String? weight,
  });

  Future<BaseResponse> requestForgetPassword({required String email});

  Future<BaseResponse> requestVerification({
    required String email,
    required String code,
  });

  Future<BaseResponse> requestResetPassword({
    required String email,
    required String password,
    required String code,
  });

  Future<BaseResponse> requestLogout();

  Future<ProfileResponse> requestProfile();

  Future<BaseResponse> requestUpdateProfile({required UserBean profile});
}
