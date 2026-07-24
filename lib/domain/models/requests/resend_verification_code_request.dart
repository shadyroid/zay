class ResendVerificationCodeRequest {
  const ResendVerificationCodeRequest({
    required this.email,
    required this.flow,
  });

  final String email;
  final String flow;

  bool get isPasswordReset => flow == 'reset';
}
