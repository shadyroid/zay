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
    final list = json['data'] as List<dynamic>?;
    List<ProductBean>? products;
    if (list != null) {
      final wishlistProducts = ProductBean.parseWishlist(list);
      products = wishlistProducts.isNotEmpty
          ? wishlistProducts
          : list
              .map((e) => ProductBean.fromJson(e as Map<String, dynamic>))
              .toList();
    }
    return ProductsResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: products,
      totalCount: json['totalCount'] as int? ?? products?.length,
    );
  }
}
