class UserBean {
  final String? name;
  final String? email;
  final String? phone;
  final String? height;
  final String? weight;
  final String? location;
  final String? avatarUrl;

  const UserBean({
    this.name,
    this.email,
    this.phone,
    this.height,
    this.weight,
    this.location,
    this.avatarUrl,
  });

  factory UserBean.fromJson(Map<String, dynamic> json) {
    final bodyProfile = json['body_profile'] as Map<String, dynamic>?;

    return UserBean(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      height: bodyProfile?['height']?.toString() ?? json['height']?.toString(),
      weight: bodyProfile?['weight']?.toString() ?? json['weight']?.toString(),
      location: json['location'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        if (height != null) 'height': height,
        if (weight != null) 'weight': weight,
        if (location != null) 'location': location,
      };
}
