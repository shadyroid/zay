class UpdateProfileRequest {
  const UpdateProfileRequest({
    this.name,
    this.email,
    this.phone,
    this.height,
    this.weight,
    this.avatarPath,
  });

  final String? name;
  final String? email;
  final String? phone;
  final String? height;
  final String? weight;
  final String? avatarPath;
}
