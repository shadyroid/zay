class ResetPasswordRequest {
  const ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.password,
    required this.passwordConfirmation,
  });

  final String email;
  final String otp;
  final String password;
  final String passwordConfirmation;
}
