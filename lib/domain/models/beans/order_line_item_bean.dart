class OrderLineItemBean {
  const OrderLineItemBean({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImageUrl,
    this.size = '',
    this.quantity = 1,
    this.unitPrice = '',
  });

  final int id;
  final int productId;
  final String productName;
  final String? productImageUrl;
  final String size;
  final int quantity;
  final String unitPrice;

  factory OrderLineItemBean.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>?;

    return OrderLineItemBean(
      id: json['id'],
      productId: json['product_id'],
      productName: _localized(json['product_name'] ?? product?['name']),
      productImageUrl: json['product_image'] as String? ??
          product?['primary_image'] as String? ??
          product?['imageUrl'] as String?,
      size: json['size_label'] as String? ??
          json['size'] as String? ??
          '',
      quantity: json['quantity'] as int? ?? 1,
      unitPrice: _formatAmount(json['unit_price'] ?? json['price']),
    );
  }

  static String _localized(dynamic value) {
    if (value is String) return value;
    if (value is Map) {
      return value['ar'] ?? value['en'];
    }
    return '';
  }

  static String _formatAmount(dynamic value) {
    if (value == null) return '0';
    if (value is String) return value.replaceAll(',', '');
    if (value is num) {
      final amount = value.toDouble();
      if (amount >= 100 && amount == amount.roundToDouble()) {
        return (amount / 100).toStringAsFixed(2);
      }
      return amount.toStringAsFixed(2);
    }
    return '0';
  }
}
