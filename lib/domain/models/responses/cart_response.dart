import 'package:hedma/domain/models/beans/cart_item_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class CartResponse extends BaseResponse {
  final List<CartItemBean>? data;

  const CartResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: CartItemBean.parseList(json['data'] as List<dynamic>?),
    );
  }
}
