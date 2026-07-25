import 'package:zay/domain/models/beans/city_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class CitiesResponse extends BaseResponse {
  final List<CityBean>? data;

  const CitiesResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory CitiesResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return CitiesResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: list
          ?.map((e) => CityBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
