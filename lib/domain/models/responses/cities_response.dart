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
    final raw = json['data'];
    final list = raw is List ? raw : null;
    return CitiesResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: list
          ?.whereType<Map>()
          .map((e) => CityBean.fromJson(Map<String, dynamic>.from(e)))
          .where((city) => city.id > 0)
          .toList(),
    );
  }
}
