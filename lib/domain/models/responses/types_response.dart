import 'package:zay/domain/models/beans/type_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class TypesResponse extends BaseResponse {
  final List<TypeBean>? data;

  const TypesResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory TypesResponse.fromJson(Map<String, dynamic> json) {
    return TypesResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((e) => TypeBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
