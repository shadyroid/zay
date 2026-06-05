import 'package:hedma/domain/models/beans/location_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class LocationDetailsResponse extends BaseResponse {
  final LocationBean? data;

  const LocationDetailsResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory LocationDetailsResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    return LocationDetailsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: raw is Map<String, dynamic> ? LocationBean.fromJson(raw) : null,
    );
  }
}
