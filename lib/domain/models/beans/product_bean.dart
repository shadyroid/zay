class ProductBean {
  final String id;
  final String name;
  final String price;
  final String? imageUrl;
  final String? shopId;
  final String? categoryId;
  final String? sizeId;
  final String? rating;
  final bool isFavorite;

  const ProductBean({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.shopId,
    this.categoryId,
    this.sizeId,
    this.rating,
    this.isFavorite = false,
  });

  factory ProductBean.fromJson(Map<String, dynamic> json) {
    return ProductBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      price: json['price']?.toString() ?? '0',
      imageUrl: json['imageUrl'] as String?,
      shopId: json['shopId']?.toString(),
      categoryId: json['categoryId']?.toString(),
      sizeId: json['sizeId']?.toString(),
      rating: json['rating']?.toString(),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  ProductBean copyWith({bool? isFavorite}) {
    return ProductBean(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      shopId: shopId,
      categoryId: categoryId,
      sizeId: sizeId,
      rating: rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
