import 'package:hedma/domain/models/beans/size_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class SizesResponse extends BaseResponse {
  final List<SizeBean>? data;

  const SizesResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory SizesResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return SizesResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: list
          ?.map((e) => SizeBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
