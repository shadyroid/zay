import 'package:zay/domain/models/beans/location_bean.dart';
import 'package:zay/domain/models/beans/order_product_bean.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/domain/models/enums/order_status.dart';
import 'package:zay/domain/models/enums/payment_method.dart';
import 'package:zay/domain/models/enums/payment_status.dart';

class OrderBean {
  final int? id;
  final String? refNumber;
  final ShopBean? shop;
  final String? subtotal;
  final String? shippingFee;
  final String? total;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final LocationBean? location;
  final String? createdAt;
  final String customerName;
  final String customerPhone;
  final List<OrderProductBean>? items;
  final bool isReviewed;

  const OrderBean({
    required this.id,
    required this.refNumber,
    required this.shop,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.status,
    required this.paymentMethod,
    this.paymentStatus = PaymentStatus.pending,
    required this.location,
    required this.createdAt,
    required this.customerName,
    required this.customerPhone,
    required this.items,
    this.isReviewed = false,
  });

  int get itemsCount => items?.length ?? 0;

  bool get isActive => status.isActive;

  bool get isCompleted => status.isCompleted;

  bool get isReturned => status.isReturned;

  bool get isCardPayment => paymentMethod == PaymentMethod.card;

  bool get needsPayment => isActive && isCardPayment && !paymentStatus.isPaid;

  bool get needsReview => isCompleted && !isReviewed;

  OrderBean copyWith({PaymentStatus? paymentStatus, bool? isReviewed}) {
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
      isReviewed: isReviewed ?? this.isReviewed,
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
      paymentMethod: PaymentMethod.fromApi(json['payment_method']?.toString()),
      paymentStatus: PaymentStatus.fromApi(json['payment_status']?.toString()),
      location: json['shipping_address'] != null
          ? LocationBean.fromJson(json['shipping_address'])
          : null,
      createdAt: json['created_at'],
      customerName: json['shipping_address']?['name'],
      customerPhone: json['shipping_address']?['phone'],
      items: (json['items'] as List?)
          ?.map((e) => OrderProductBean.fromJson(e))
          .toList(),
      isReviewed: json['is_reviewed'] == true || json['is_reviewed'] == 1,
    );
  }
}
