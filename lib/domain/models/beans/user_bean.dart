class UserBean {
  final String? name;
  final String? email;
  final String? phone;

  const UserBean({this.name, this.email, this.phone});

  factory UserBean.fromJson(Map<String, dynamic> json) {
    return UserBean(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
      };
}
