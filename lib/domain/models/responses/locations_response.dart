import 'package:hedma/domain/models/beans/location_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class LocationsResponse extends BaseResponse {
  final List<LocationBean>? data;

  const LocationsResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory LocationsResponse.fromJson(Map<String, dynamic> json) {
    return LocationsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: LocationBean.listFromJson(json['data'] as List<dynamic>?),
    );
  }
}
