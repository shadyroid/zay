import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class ShopsResponse extends BaseResponse {
  final List<ShopBean>? data;

  const ShopsResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory ShopsResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return ShopsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: list
          ?.map((e) => ShopBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
