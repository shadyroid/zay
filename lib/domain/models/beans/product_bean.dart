import 'package:get/get.dart';
import 'package:hedma/app/utils/likes_util.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_size_bean.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';

class ProductBean {
  final int? id;
  final String? name;
  final String? price;
  final String? image;
  final List<String>? images;
  final ShopBean? shop;
  final CategoryBean? category;
  final String? sellerCategories;
  final int? sizeId;
  final String? rating;
  final int? reviewCount;
  final String? description;
  final List<ProductSizeBean> sizes;
  final RxBool isFavorite;

  ProductBean({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.images ,
    required this.sellerCategories,
    required this.shop,
    required this.category,
    required this.sizeId,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.sizes,
    required this.isFavorite,
  });

  factory ProductBean.fromJson(Map<String, dynamic> json) {
    return ProductBean(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['base_price'], //original_price, discount_percentage
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
      isFavorite: LikesUtil.productLike(
        json['id'],
        isFavorite: json['is_favorite'],
      ),

      sellerCategories: json['sellerCategories'] as String?,
      sizeId: json['sizeId'],
      sizes: _parseSizes(json['sizes']),

    );
  }




  static List<ProductSizeBean> _parseSizes(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => ProductSizeBean.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

}
