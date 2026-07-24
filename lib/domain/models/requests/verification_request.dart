class VerificationRequest {
  const VerificationRequest({
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;
}
