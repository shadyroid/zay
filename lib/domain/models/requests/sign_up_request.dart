class SignUpRequest {
  const SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.height,
    required this.weight,
    this.phone,
  });

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String height;
  final String weight;
  final String? phone;
}
