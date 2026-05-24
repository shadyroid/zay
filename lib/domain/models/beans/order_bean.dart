import 'package:hedma/domain/models/beans/order_track_step_bean.dart';

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
  final String? estimatedDelivery;
  final List<OrderTrackStepBean>? steps;

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
    this.estimatedDelivery,
    this.steps,
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
      case 'cash_on_delivery':
        return 'cash';
      case 'card':
        return 'card';
      default:
        return paymentMethod.isNotEmpty ? paymentMethod : 'cash';
    }
  }

  factory OrderBean.fromJson(Map<String, dynamic> json) {
    final lineItem = _firstLineItem(json);
    final productNameField = lineItem?['product_name'] ??
        (lineItem?['product'] as Map<String, dynamic>?)?['name'];
    final shippingAddress = json['shipping_address'] as Map<String, dynamic>?;
    final createdAt =
        json['created_at'] as String? ?? json['date'] as String? ?? '';
    final productName = _localized(productNameField);

    return OrderBean(
      id: json['id']?.toString() ?? '',
      status: _resolveStatus(json),
      total: _formatAmount(json['total']),
      date: _formatDate(createdAt),
      itemCount: _resolveItemCount(json),
      productName: productName.isNotEmpty
          ? productName
          : _productNameFromSubOrders(json),
      productImageUrl: lineItem?['product_image'] as String? ??
          lineItem?['productImageUrl'] as String?,
      size: lineItem?['size_label'] as String? ??
          lineItem?['size'] as String? ??
          '',
      quantity: lineItem?['quantity'] as int? ?? 1,
      customerName: json['recipient_name'] as String? ??
          json['customerName'] as String? ??
          '',
      customerAddress: shippingAddress != null
          ? _formatAddress(shippingAddress)
          : json['customerAddress'] as String? ?? '',
      customerPhone: json['recipient_phone'] as String? ??
          json['customerPhone'] as String? ??
          '',
      customerImageUrl: json['customerImageUrl'] as String?,
      subtotal: _formatAmount(json['subtotal']),
      shipping: _formatAmount(json['shipping_fee'] ?? json['shipping']),
      paymentMethod: _normalizePaymentMethod(
        json['payment_method'] as String? ?? json['paymentMethod'] as String?,
      ),
      summaryDate: _formatSummaryDate(createdAt),
      estimatedDelivery: json['estimated_delivery'] as String? ??
          json['estimatedDelivery'] as String?,
      steps: _parseSteps(json['steps']),
    );
  }

  static List<OrderTrackStepBean>? _parseSteps(dynamic value) {
    if (value is! List) return null;
    return value
        .whereType<Map<String, dynamic>>()
        .map(OrderTrackStepBean.fromJson)
        .toList();
  }

  static Map<String, dynamic>? _firstLineItem(Map<String, dynamic> json) {
    final subOrders = json['sub_orders'] as List<dynamic>?;
    if (subOrders == null) return null;

    for (final sub in subOrders) {
      if (sub is! Map<String, dynamic>) continue;
      final items = sub['items'] as List<dynamic>?;
      if (items == null || items.isEmpty) continue;
      final first = items.first;
      if (first is Map<String, dynamic>) return first;
    }
    return null;
  }

  static String _resolveStatus(Map<String, dynamic> json) {
    final direct = json['status'] as String?;
    if (direct != null && direct.isNotEmpty) return direct;

    final subOrders = json['sub_orders'] as List<dynamic>?;
    if (subOrders == null || subOrders.isEmpty) return '';

    final first = subOrders.first;
    if (first is Map<String, dynamic>) {
      return first['status'] as String? ?? '';
    }
    return '';
  }

  static int _resolveItemCount(Map<String, dynamic> json) {
    final explicit = json['itemCount'] as int?;
    if (explicit != null) return explicit;

    final subOrders = json['sub_orders'] as List<dynamic>?;
    if (subOrders == null) return 0;

    var count = 0;
    for (final sub in subOrders) {
      if (sub is! Map<String, dynamic>) continue;
      final items = sub['items'] as List<dynamic>?;
      if (items != null && items.isNotEmpty) {
        for (final item in items) {
          if (item is Map<String, dynamic>) {
            count += item['quantity'] as int? ?? 1;
          }
        }
      } else {
        count += sub['items_count'] as int? ?? 0;
      }
    }
    return count;
  }

  static String _productNameFromSubOrders(Map<String, dynamic> json) {
    final subOrders = json['sub_orders'] as List<dynamic>?;
    if (subOrders == null || subOrders.isEmpty) return '';

    final first = subOrders.first;
    if (first is! Map<String, dynamic>) return '';

    return _localized(first['shop']);
  }

  static String _localized(dynamic value) {
    if (value is String) return value;
    if (value is Map) {
      return value['ar']?.toString() ?? value['en']?.toString() ?? '';
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

  static String _formatAddress(Map<String, dynamic> address) {
    final full = address['full_address'] as String?;
    if (full != null && full.isNotEmpty) return full;

    final parts = <String>[
      address['street'] as String? ?? '',
      address['city'] as String? ?? '',
      address['governorate'] as String? ?? '',
    ].where((part) => part.isNotEmpty).toList();

    return parts.join(', ');
  }

  static String _normalizePaymentMethod(String? method) {
    if (method == null || method.isEmpty) return '';
    if (method == 'cash_on_delivery') return 'cash';
    return method;
  }

  static String _formatDate(String value) {
    if (value.isEmpty) return '';
    if (value.length >= 10) return value.substring(0, 10);
    return value;
  }

  static String _formatSummaryDate(String value) {
    if (value.length >= 10) {
      final parts = value.substring(0, 10).split('-');
      if (parts.length == 3) {
        return '${parts[2]}-${parts[1]}-${parts[0]}';
      }
    }
    return value;
  }
}
