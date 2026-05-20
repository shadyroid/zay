import 'package:get/get.dart';
import 'package:hedma/data/repositories/auth_repository_impl.dart';
import 'package:hedma/domain/models/beans/user_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/profile_response.dart';
import 'package:hedma/domain/models/responses/sign_in_response.dart';
import 'package:hedma/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository = Get.put(AuthRepositoryImpl());

  Future<SignInResponse> requestSignIn({
    required String email,
    required String password,
  }) =>
      _authRepository.requestSignIn(email: email, password: password);

  Future<SignInResponse> requestSignUp({
    required String name,
    required String email,
    required String password,
  }) =>
      _authRepository.requestSignUp(
        name: name,
        email: email,
        password: password,
      );

  Future<BaseResponse> requestForgetPassword({required String email}) =>
      _authRepository.requestForgetPassword(email: email);

  Future<BaseResponse> requestVerification({
    required String email,
    required String code,
  }) =>
      _authRepository.requestVerification(email: email, code: code);

  Future<BaseResponse> requestResetPassword({
    required String email,
    required String password,
    required String code,
  }) =>
      _authRepository.requestResetPassword(
        email: email,
        password: password,
        code: code,
      );

  Future<BaseResponse> requestLogout() => _authRepository.requestLogout();

  Future<ProfileResponse> requestProfile() => _authRepository.requestProfile();

  Future<BaseResponse> requestUpdateProfile({required UserBean profile}) =>
      _authRepository.requestUpdateProfile(profile: profile);
}
