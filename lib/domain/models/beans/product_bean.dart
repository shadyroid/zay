class ProductBean {
  final String id;
  final String name;
  final String price;
  final String? imageUrl;
  final String? shopId;

  const ProductBean({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.shopId,
  });

  factory ProductBean.fromJson(Map<String, dynamic> json) {
    return ProductBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      price: json['price']?.toString() ?? '0',
      imageUrl: json['imageUrl'] as String?,
      shopId: json['shopId']?.toString(),
    );
  }
}
