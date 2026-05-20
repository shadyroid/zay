class CartItemBean {
  final String id;
  final String name;
  final String price;
  final String? imageUrl;
  final String? sizeLabel;
  final int quantity;

  const CartItemBean({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.sizeLabel,
    this.quantity = 1,
  });

  factory CartItemBean.fromJson(Map<String, dynamic> json) {
    return CartItemBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      price: json['price']?.toString() ?? '0',
      imageUrl: json['imageUrl'] as String?,
      sizeLabel: json['sizeLabel'] as String?,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  CartItemBean copyWith({int? quantity}) {
    return CartItemBean(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      sizeLabel: sizeLabel,
      quantity: quantity ?? this.quantity,
    );
  }

  double get lineTotal => (double.tryParse(price) ?? 0) * quantity;
}
