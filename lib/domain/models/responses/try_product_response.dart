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
    String? imageUrl;

    if (data is Map<String, dynamic>) {
      imageUrl = data['image_url'] as String? ??
          data['imageUrl'] as String? ??
          data['photo'] as String? ??
          data['result_url'] as String?;
    } else if (data is String) {
      imageUrl = data;
    }

    imageUrl ??= json['image_url'] as String? ?? json['imageUrl'] as String?;

    return TryProductResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'] as String?,
      imageUrl: imageUrl,
    );
  }
}
