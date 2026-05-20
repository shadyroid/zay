class OrderBean {
  final String id;
  final String status;
  final String total;
  final String date;
  final int itemCount;
  final String productName;
  final String? productImageUrl;
  final String size;
  final int quantity;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final String? customerImageUrl;
  final String subtotal;
  final String shipping;
  final String paymentMethod;
  final String summaryDate;

  const OrderBean({
    required this.id,
    required this.status,
    required this.total,
    required this.date,
    required this.itemCount,
    required this.productName,
    this.productImageUrl,
    this.size = '',
    this.quantity = 1,
    this.customerName = '',
    this.customerAddress = '',
    this.customerPhone = '',
    this.customerImageUrl,
    this.subtotal = '',
    this.shipping = '0',
    this.paymentMethod = '',
    this.summaryDate = '',
  });

  bool get isActive {
    final value = status.toLowerCase();
    return value == 'pending' ||
        value == 'confirmed' ||
        value == 'shipped' ||
        value == 'processing';
  }

  bool get isCompleted => status.toLowerCase() == 'delivered';

  bool get isReturned => status.toLowerCase() == 'returned';

  String get displaySubtotal =>
      subtotal.isNotEmpty ? subtotal : total;

  String get displaySummaryDate =>
      summaryDate.isNotEmpty ? summaryDate : date;

  String get paymentMethodLabel {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return 'cash';
      case 'card':
        return 'card';
      default:
        return paymentMethod.isNotEmpty ? paymentMethod : 'cash';
    }
  }

  factory OrderBean.fromJson(Map<String, dynamic> json) {
    final total = json['total']?.toString() ?? '0';
    return OrderBean(
      id: json['id']?.toString() ?? '',
      status: json['status'] as String? ?? '',
      total: total,
      date: json['date'] as String? ?? '',
      itemCount: json['itemCount'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      productImageUrl: json['productImageUrl'] as String?,
      size: json['size'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      customerName: json['customerName'] as String? ?? '',
      customerAddress: json['customerAddress'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
      customerImageUrl: json['customerImageUrl'] as String?,
      subtotal: json['subtotal']?.toString() ?? total,
      shipping: json['shipping']?.toString() ?? '0',
      paymentMethod: json['paymentMethod'] as String? ?? '',
      summaryDate: json['summaryDate'] as String? ?? '',
    );
  }
}
