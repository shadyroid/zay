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
  final bool isFavorite;

  const ProductBean({
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
    this.isFavorite = false,
  });

  factory ProductBean.fromJson(Map<String, dynamic> json) {
    final images = json['imageUrls'] as List<dynamic>?;
    final sizesList = json['sizes'] as List<dynamic>?;

    return ProductBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      price: json['price']?.toString() ?? '0',
      imageUrl: json['imageUrl'] as String?,
      imageUrls: images?.map((e) => e.toString()).toList() ??
          (json['imageUrl'] != null ? [json['imageUrl'] as String] : []),
      shopId: json['shopId']?.toString(),
      shopName: json['shopName'] as String?,
      sellerCategories: json['sellerCategories'] as String?,
      categoryId: json['categoryId']?.toString(),
      sizeId: json['sizeId']?.toString(),
      rating: json['rating']?.toString(),
      reviewCount: json['reviewCount'] as int?,
      description: json['description'] as String?,
      sizes: sizesList
              ?.map((e) => ProductSizeBean.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  List<String> get galleryImages {
    if (imageUrls.isNotEmpty) return imageUrls;
    if (imageUrl != null && imageUrl!.isNotEmpty) return [imageUrl!];
    return const [];
  }

  ProductBean copyWith({bool? isFavorite}) {
    return ProductBean(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      imageUrls: imageUrls,
      shopId: shopId,
      shopName: shopName,
      sellerCategories: sellerCategories,
      categoryId: categoryId,
      sizeId: sizeId,
      rating: rating,
      reviewCount: reviewCount,
      description: description,
      sizes: sizes,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
