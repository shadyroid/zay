import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class ProductsResponse extends BaseResponse {
  final List<ProductBean>? data;

  const ProductsResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return ProductsResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: list
          ?.map((e) => ProductBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
