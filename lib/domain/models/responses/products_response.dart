import 'package:hedma/domain/models/beans/product_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class ProductsResponse extends BaseResponse {
  final List<ProductBean>? data;
  final int? totalCount;

  const ProductsResponse({
    required super.statusCode,
    super.message,
    this.data,
    this.totalCount,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => ProductBean.fromJson(e))
          .toList(),
      totalCount: json['totalCount'],
    );
  }
}
