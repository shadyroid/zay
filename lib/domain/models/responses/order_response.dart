import 'package:zay/domain/models/beans/order_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class OrderResponse extends BaseResponse {
  final OrderBean? data;
  final String? paymentUrl;
  final String? paymentStatus;

  const OrderResponse({
    required super.statusCode,
    super.message,
    this.data,
    this.paymentUrl,
    this.paymentStatus,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: json['data'] != null
          ? OrderBean.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      paymentUrl: json['payment_url'] as String?,
      paymentStatus: json['payment_status'] as String?,
    );
  }
}
