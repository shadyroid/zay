import 'package:zay/app/utils/parser.dart';

class CartItemBean {
  final int id;
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
    final product = json['product'] as Map<String, dynamic>?;
    final size = json['size'] as Map<String, dynamic>?;

    return CartItemBean(
      id: json['id'] ?? product?['id'],
      name: product?['name'] as String? ?? json['name'],
      price: Parser.parseString(json['unit_price'] ?? json['price']) ?? '0',
      imageUrl: product?['image'] as String? ??
          product?['imageUrl'] as String? ??
          json['imageUrl'] as String?,
      sizeLabel: size?['label'] as String? ?? json['sizeLabel'] as String?,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  static List<CartItemBean> parseList(List<dynamic>? raw) {
    if (raw == null) return [];

    final result = <CartItemBean>[];
    for (final entry in raw) {
      if (entry is! Map<String, dynamic>) continue;

      final nested = entry['items'] as List<dynamic>?;
      if (nested != null) {
        for (final item in nested) {
          if (item is Map<String, dynamic>) {
            result.add(CartItemBean.fromJson(item));
          }
        }
      } else {
        result.add(CartItemBean.fromJson(entry));
      }
    }
    return result;
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

  double get lineTotal {
    final normalized = price.replaceAll(',', '');
    return (double.tryParse(normalized) ?? 0) * quantity;
  }
}
