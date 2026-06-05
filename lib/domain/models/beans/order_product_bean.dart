class OrderProductBean {
  final int? id;
  final int? productId;
  final String? productName;
  final String? productImage;
  final String? sizeLabel;
  final String? sizeMeasurements;
  final int? quantity;
  final String? unitPrice;
  final String? total;

  OrderProductBean({
    this.id,
    this.productId,
    this.productName,
    this.productImage,
    this.sizeLabel,
    this.sizeMeasurements,
    this.quantity,
    this.unitPrice,
    this.total,
  });

  factory OrderProductBean.fromJson(Map<String, dynamic> json) {
    return OrderProductBean(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productImage: json['product_image'],
      sizeLabel: json['size_label'],
      sizeMeasurements: json['size_measurements'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      total: json['total'],
    );
  }
}
