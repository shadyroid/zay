import 'package:hedma/domain/models/responses/base_response.dart';

class TryProductResponse extends BaseResponse {
  final String? imageUrl;

  const TryProductResponse({
    required super.statusCode,
    super.message,
    this.imageUrl,
  });

  factory TryProductResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return TryProductResponse(
      statusCode: json['statusCode'] as int? ?? -2,
      message: json['message'] as String?,
      imageUrl: data is Map<String, dynamic>
          ? data['imageUrl'] as String?
          : data as String?,
    );
  }
}
