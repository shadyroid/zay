import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class OrdersResponse extends BaseResponse {
  final List<OrderBean>? data;

  const OrdersResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return OrdersResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: list
          ?.map((e) => OrderBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
