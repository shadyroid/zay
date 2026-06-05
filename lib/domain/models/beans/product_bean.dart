import 'package:get/get.dart';
import 'package:hedma/app/utils/likes_util.dart';
import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/beans/product_size_bean.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';

class ProductBean {
  final int? id;
  final String? name;
  final String? price;
  final String? imageUrl;
  final List<String>? imageUrls;
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
    this.imageUrl,
    this.imageUrls = const [],
    this.sellerCategories,
    this.shop,
    this.category,
    this.sizeId,
    this.rating,
    this.reviewCount,
    this.description,
    this.sizes = const [],
    required this.isFavorite,
  });

  factory ProductBean.fromJson(Map<String, dynamic> json) {
    return ProductBean(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['base_price'], //original_price, discount_percentage
      imageUrl: json['primary_image'],
      imageUrls: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      rating: json['avg_rating'],
      reviewCount: json['reviews_count'],
      shop: json['shop'] != null
          ? ShopBean.fromJson(json['shop'] as Map<String, dynamic>)
          : null,
      category: json['category'] != null
          ? CategoryBean.fromJson(json['category'] as Map<String, dynamic>)
          : null,

      sellerCategories: json['sellerCategories'] as String?,
      sizeId: json['sizeId'],
      sizes: _parseSizes(json['sizes']),
      isFavorite: LikesUtil.productLike(
        json['id'],
        isFavorite: json['is_favorite'],
      ),
    );
  }

  static List<ProductBean> parseWishlist(List<dynamic>? raw) {
    if (raw == null) return [];

    return raw.map((entry) {
      if (entry is Map<String, dynamic> && entry['product'] is Map) {
        final product = Map<String, dynamic>.from(entry['product'] as Map);
        LikesUtil.productLike(
          product['id'],
          isFavorite: true,
        );
        return ProductBean.fromJson(product);
      }
      return null;
    }).whereType<ProductBean>().toList();
  }

  static String? _localizedName(dynamic value) {
    if (value is String) return value;
    if (value is Map) {
      return value['ar']?.toString() ?? value['en']?.toString();
    }
    return null;
  }

  static List<String> _resolveImageUrls(Map<String, dynamic> json) {
    final apiImages = json['images'] as List<dynamic>?;
    if (apiImages != null && apiImages.isNotEmpty) {
      return apiImages
          .whereType<Map>()
          .map((image) => image['url']?.toString())
          .whereType<String>()
          .where((url) => url.isNotEmpty)
          .toList();
    }

    final legacyImages = json['imageUrls'] as List<dynamic>?;
    if (legacyImages != null && legacyImages.isNotEmpty) {
      return legacyImages.map((e) => e.toString()).toList();
    }

    final primaryImage = json['primary_image'] as String?;
    if (primaryImage != null && primaryImage.isNotEmpty) {
      return [primaryImage];
    }

    final imageUrl = json['imageUrl'] as String?;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return [imageUrl];
    }

    return const [];
  }

  static List<ProductSizeBean> _parseSizes(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => ProductSizeBean.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

}
