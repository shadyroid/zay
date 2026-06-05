//Done Review
class UserBean {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final int? height;
  final int? weight;
  final String? avatarUrl;

  const UserBean({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.height,
    this.weight,
    this.avatarUrl,
  });

  factory UserBean.fromJson(Map<String, dynamic> json) {
    return UserBean(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      height: json['body_profile']?['height'],
      weight: json['body_profile']?['weight'],
      avatarUrl: json['avatar_url'],
    );
  }
}
