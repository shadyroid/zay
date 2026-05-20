class AuthBean {
  final String? token;

  const AuthBean({this.token});

  factory AuthBean.fromJson(Map<String, dynamic> json) {
    return AuthBean(
      token: json['token'] as String?,
    );
  }
}
