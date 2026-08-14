import 'package:zay/domain/models/beans/location_bean.dart';
import 'package:zay/domain/models/beans/order_product_bean.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/domain/models/enums/order_status.dart';

class OrderBean {
  final int? id;
  final String? refNumber;
  final ShopBean? shop;
  final String? subtotal;
  final String? shippingFee;
  final String? total;
  final OrderStatus status;
  final String? paymentMethod;
  final String? paymentStatus;
  final LocationBean? location;
  final String? createdAt;
  final String customerName;
  final String customerPhone;
  final List<OrderProductBean>? items;

  const OrderBean({
    required this.id,
    required this.refNumber,
    required this.shop,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.status,
    required this.paymentMethod,
    this.paymentStatus,
    required this.location,
    required this.createdAt,
    required this.customerName,
    required this.customerPhone,
    required this.items,
  });

  int get itemsCount => items?.length ?? 0;

  bool get isActive => status.isActive;

  bool get isCompleted => status.isCompleted;

  bool get isReturned => status.isReturned;

  bool get isCardPayment => paymentMethod == 'card';

  bool get needsPayment {
    if (!isCardPayment) return false;
    final value = paymentStatus?.toLowerCase();
    return value != 'paid' && value != 'captured' && value != 'success';
  }

  OrderBean copyWith({String? paymentStatus}) {
    return OrderBean(
      id: id,
      refNumber: refNumber,
      shop: shop,
      subtotal: subtotal,
      shippingFee: shippingFee,
      total: total,
      status: status,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      location: location,
      createdAt: createdAt,
      customerName: customerName,
      customerPhone: customerPhone,
      items: items,
    );
  }

  factory OrderBean.fromJson(Map<String, dynamic> json) {
    return OrderBean(
      id: json['id'],
      refNumber: json['order_number'],
      shop: json['shop'] != null ? ShopBean.fromJson(json['shop']) : null,
      subtotal: json['subtotal'],
      shippingFee: json['shipping_fee'],
      total: json['total'],
      status: OrderStatus.fromApi(json['status']?.toString()),
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'] as String?,
      location: json['shipping_address'] != null
          ? LocationBean.fromJson(json['shipping_address'])
          : null,
      createdAt: json['created_at'],
      customerName: json['shipping_address']?['name'],
      customerPhone: json['shipping_address']?['phone'],
      items: (json['items'] as List?)
          ?.map((e) => OrderProductBean.fromJson(e))
          .toList(),
    );
  }
}
