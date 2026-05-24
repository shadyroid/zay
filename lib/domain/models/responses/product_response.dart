import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class ProductResponse extends BaseResponse {
  final ProductBean? data;
  final List<ProductBean>? similarProducts;

  const ProductResponse({
    required super.statusCode,
    super.message,
    this.data,
    this.similarProducts,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    final similar = json['similarProducts'] as List<dynamic>?;
    return ProductResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ProductBean.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      similarProducts: similar
          ?.map((e) => ProductBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
