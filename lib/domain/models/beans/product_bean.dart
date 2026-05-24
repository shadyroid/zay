import 'package:get/get.dart';
import 'package:hedma/app/utils/likes_util.dart';
import 'package:hedma/domain/models/beans/product_size_bean.dart';

class ProductBean {
  final String id;
  final String name;
  final String price;
  final String? imageUrl;
  final List<String> imageUrls;
  final String? shopId;
  final String? shopName;
  final String? sellerCategories;
  final String? categoryId;
  final String? sizeId;
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
    this.shopId,
    this.shopName,
    this.sellerCategories,
    this.categoryId,
    this.sizeId,
    this.rating,
    this.reviewCount,
    this.description,
    this.sizes = const [],
    required this.isFavorite,
  });

  factory ProductBean.fromJson(Map<String, dynamic> json) {
    final shop = json['shop'] as Map<String, dynamic>?;
    final imageUrls = _resolveImageUrls(json);
    final id = json['id']?.toString() ?? '';

    return ProductBean(
      id: id,
      name: _localizedName(json['name']) ?? '',
      price: json['base_price']?.toString() ??
          json['price']?.toString() ??
          '0',
      imageUrl: imageUrls.isNotEmpty ? imageUrls.first : json['imageUrl'] as String?,
      imageUrls: imageUrls,
      shopId: shop?['id']?.toString() ?? json['shopId']?.toString(),
      shopName: _localizedName(shop?['name']) ?? json['shopName'] as String?,
      sellerCategories: json['sellerCategories'] as String?,
      categoryId: json['category_id']?.toString() ??
          json['categoryId']?.toString(),
      sizeId: json['sizeId']?.toString(),
      rating: json['avg_rating']?.toString() ?? json['rating']?.toString(),
      reviewCount:
          json['reviews_count'] as int? ?? json['reviewCount'] as int?,
      description: json['description'] as String?,
      sizes: _parseSizes(json['sizes']),
      isFavorite: LikesUtil.productLike(
        id,
        isFavorite: json['isFavorite'] as bool? ??
            json['is_favorite'] as bool?,
      ),
    );
  }

  static List<ProductBean> parseWishlist(List<dynamic>? raw) {
    if (raw == null) return [];

    return raw.map((entry) {
      if (entry is Map<String, dynamic> && entry['product'] is Map) {
        final product = Map<String, dynamic>.from(entry['product'] as Map);
        LikesUtil.productLike(
          product['id']?.toString() ?? '',
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

  List<String> get galleryImages {
    if (imageUrls.isNotEmpty) return imageUrls;
    if (imageUrl != null && imageUrl!.isNotEmpty) return [imageUrl!];
    return const [];
  }
}
