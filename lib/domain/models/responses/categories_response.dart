import 'package:hedma/domain/models/beans/category_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class CategoriesResponse extends BaseResponse {
  final List<CategoryBean>? data;

  const CategoriesResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return CategoriesResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: list
          ?.map((e) => CategoryBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
