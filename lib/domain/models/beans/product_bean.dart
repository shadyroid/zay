import 'package:get/get.dart';
import 'package:zay/app/utils/likes_util.dart';
import 'package:zay/app/utils/parser.dart';
import 'package:zay/domain/models/beans/category_bean.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/domain/models/beans/size_bean.dart';

class ProductBean {
  final int? id;
  final String? name;
  final double? price;
  final double? originalPrice;
  final String? image;
  final List<String>? images;
  final ShopBean? shop;
  final CategoryBean? category;
  final String? rating;
  final int? reviewCount;
  final String? description;
  final List<SizeBean>? sizes;
  final RxBool isFavorite;
  final Map<int, int>? selectedSizesQuantities;
  final bool? isOutOfStock;

  ProductBean({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.image,
    required this.images,
    required this.shop,
    required this.category,
    required this.isOutOfStock,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.sizes,
    required this.isFavorite,
    required this.selectedSizesQuantities,
  });

  factory ProductBean.fromJson(Map<String, dynamic> json) {
    return ProductBean(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: Parser.parseDouble(json['base_price']),
      originalPrice: Parser.parseDouble(json['original_price']),
      image: json['primary_image'],
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      rating: json['avg_rating'],
      reviewCount: json['reviews_count'],
      shop: json['shop'] != null
          ? ShopBean.fromJson(json['shop'] as Map<String, dynamic>)
          : null,
      category: json['category'] != null
          ? CategoryBean.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      isOutOfStock: json['out_of_stock'],
      isFavorite: LikesUtil.productLike(
        json['id'],
        isFavorite: json['is_favorite'],
      ),
      //From cart
      selectedSizesQuantities: json['selectedSizesQuantities'],

      sizes: _parseSizes(json['sizes']),
    );
  }

  static List<SizeBean> _parseSizes(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => SizeBean.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
