import 'package:zay/app/utils/parser.dart';
import 'package:zay/domain/models/beans/location_bean.dart';
import 'package:zay/domain/models/beans/order_product_bean.dart';
import 'package:zay/domain/models/beans/order_track_step_bean.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';

class OrderBean {
  final int? id;
  final String? refNumber;
  final ShopBean? shop;
  final String? subtotal;
  final String? shippingFee;
  final String? total;
  final String? status;
  final String? paymentMethod;
  final LocationBean? location;
  final String? createdAt;
  // final String productName;
  // final String? productImageUrl;
  // final String size;
  // final int quantity;
  final String customerName;
  // final String customerAddress;
  final String customerPhone;
  // final String? customerImageUrl;
  // final String? estimatedDelivery;
  // final List<OrderTrackStepBean>? steps;
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
    required this.location,
    required this.createdAt,
    required this.customerName,
    required this.customerPhone,
    required this.items,
  });

  int get itemsCount => items?.length ?? 0;

  bool get isActive {
    final value = status?.toLowerCase();
    return value == 'pending' ||
        value == 'confirmed' ||
        value == 'shipped' ||
        value == 'processing';
  }

  bool get isCompleted => status?.toLowerCase() == 'delivered';

  bool get isReturned => status?.toLowerCase() == 'returned';

  factory OrderBean.fromJson(Map<String, dynamic> json) {

    return OrderBean(
      id: json['id'],
      refNumber: json['order_number'],
      shop: json['shop'] != null ? ShopBean.fromJson(json['shop']) : null,
      subtotal: json['subtotal'],
      shippingFee: json['shipping_fee'],
      total: json['total'],
      status: json['status'],
      //status_label
      paymentMethod: json['payment_method'],
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
