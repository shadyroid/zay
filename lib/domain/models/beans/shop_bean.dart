class ShopBean {
  final String id;
  final String name;
  final String? description;
  final String? about;
  final String? iconUrl;
  final String? logoUrl;
  final String? bannerUrl;
  final String? imageUrl;
  final String? rating;
  final int? reviewCount;

  const ShopBean({
    required this.id,
    required this.name,
    this.description,
    this.about,
    this.iconUrl,
    this.logoUrl,
    this.bannerUrl,
    this.imageUrl,
    this.rating,
    this.reviewCount,
  });

  factory ShopBean.fromJson(Map<String, dynamic> json) {
    return ShopBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      about: json['about'] as String?,
      iconUrl: json['iconUrl'] as String?,
      logoUrl: json['logoUrl'] as String? ?? json['imageUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      rating: json['rating']?.toString(),
      reviewCount: json['reviewCount'] as int?,
    );
  }
}
