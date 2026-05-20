class ShopBean {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;

  const ShopBean({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
  });

  factory ShopBean.fromJson(Map<String, dynamic> json) {
    return ShopBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
