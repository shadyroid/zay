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
    return CategoriesResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'] as String?,
      data: CategoryBean.parseFlattenedList(json['data'] as List<dynamic>?),
    );
  }
}
