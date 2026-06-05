import 'package:hedma/app/utils/parser.dart';

class ShopBean {
  final int? id;
  final String? name;
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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rating: Parser.parseString(json['avg_rating']),
      logoUrl: json['logo_url'],
      bannerUrl: json['cover_url'],


      about: json['about'] as String? ?? json['return_policy'] as String?,
      iconUrl: json['iconUrl'] as String?,
      imageUrl: logoUrl,
      reviewCount: json['products_count'] as int? ?? json['reviewCount'] as int?,
    );
  }
}
