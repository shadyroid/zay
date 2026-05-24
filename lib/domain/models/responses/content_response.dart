import 'package:hedma/domain/models/responses/base_response.dart';

class ContentResponse extends BaseResponse {
  final String? data;

  const ContentResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory ContentResponse.fromJson(Map<String, dynamic> json) {
    return ContentResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'] as String?,
      data: json['data'] as String?,
    );
  }
}
