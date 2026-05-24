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
    final logoUrl = json['logo_url'] as String? ??
        json['logoUrl'] as String? ??
        json['imageUrl'] as String?;

    return ShopBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      about: json['about'] as String? ?? json['return_policy'] as String?,
      iconUrl: json['iconUrl'] as String?,
      logoUrl: logoUrl,
      bannerUrl: json['cover_url'] as String? ?? json['bannerUrl'] as String?,
      imageUrl: logoUrl,
      rating: json['avg_rating']?.toString() ?? json['rating']?.toString(),
      reviewCount:
          json['products_count'] as int? ?? json['reviewCount'] as int?,
    );
  }
}
