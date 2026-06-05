import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class ShopResponse extends BaseResponse {
  final ShopBean? data;

  const ShopResponse({required super.statusCode, super.message, this.data});

  factory ShopResponse.fromJson(Map<String, dynamic> json) {
    return ShopResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: json['data'] != null
          ? ShopBean.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
