import 'package:hedma/domain/models/responses/base_response.dart';

class OrderTrackResponse extends BaseResponse {
  final List<String>? data;

  const OrderTrackResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory OrderTrackResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return OrderTrackResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      data: list?.map((e) => e.toString()).toList(),
    );
  }
}
