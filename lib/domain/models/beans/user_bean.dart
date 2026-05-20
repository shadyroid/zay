class UserBean {
  final String? name;
  final String? email;
  final String? phone;
  final String? height;
  final String? weight;
  final String? location;

  const UserBean({
    this.name,
    this.email,
    this.phone,
    this.height,
    this.weight,
    this.location,
  });

  factory UserBean.fromJson(Map<String, dynamic> json) {
    return UserBean(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      location: json['location'] as String?,
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
