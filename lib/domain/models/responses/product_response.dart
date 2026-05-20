import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class ProductResponse extends BaseResponse {
  final ProductBean? data;

  const ProductResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ProductBean.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
