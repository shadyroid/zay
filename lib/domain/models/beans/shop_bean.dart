import 'package:hedma/app/utils/parser.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';

//Done Review Need BE Edits
class ShopBean {
  final int? id;
  final String? name;
  final String? description;
  final String? slogan;
  final String? icon;
  final String? logo;
  final String? banner;
  final String? rating;
  final int? reviewCount;
  final List<CategoryBean>? categories;

  const ShopBean({
    required this.id,
    required this.name,
    required this.description,
    required this.slogan,
    required this.icon,
    required this.logo,
    required this.banner,
    required this.rating,
    required this.reviewCount,
    required this.categories,
  });

  factory ShopBean.fromJson(Map<String, dynamic> json) {
    return ShopBean(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo_url'] ?? json['logo'],//logo_url from shops , logo From product
      banner: json['cover_url'],//banner_url
      icon: json['icon_url'],//??
      slogan: json['slogan'],//??
      rating: Parser.parseString(json['avg_rating']),
      reviewCount: json['review_count'],//??
      categories: (json['categories'] as List?)?.map((e) => CategoryBean.fromJson(e)).toList(),
    );
  }
}
