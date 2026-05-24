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
      if (_isWishlistList(list)) {
        products = ProductBean.parseWishlist(list);
      } else {
        products = list
            .map((e) => ProductBean.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return ProductsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'] as String?,
      data: products,
      totalCount: json['totalCount'] as int? ?? products?.length,
    );
  }

  static bool _isWishlistList(List<dynamic> list) {
    if (list.isEmpty) return false;
    final first = list.first;
    return first is Map<String, dynamic> && first.containsKey('product');
  }
}
