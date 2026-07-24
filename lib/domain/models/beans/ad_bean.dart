class AdBean {
  final int? id;
  final String? image;

  const AdBean({
    required this.id,
    required this.image,
  });

  factory AdBean.fromJson(Map<String, dynamic> json) {
    return AdBean(
      id: json['id'],
      image: json['image_url'] ?? json['image'],
    );
  }
}
