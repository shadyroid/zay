import 'package:zay/domain/models/responses/base_response.dart';

class TryOnResponse extends BaseResponse {
  final int? id;
  final String? imageUrl;
  final int? allowedTriesToday;

  const TryOnResponse({
    required super.statusCode,
    super.message,
    this.id,
    this.imageUrl,
    this.allowedTriesToday,
  });

  factory TryOnResponse.fromJson(Map<String, dynamic> json) {
    return TryOnResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      id: json['request_id'],
      imageUrl: json['result_image_url'],
      allowedTriesToday: _readAllowedTriesToday(json),
    );
  }

  static int? _readAllowedTriesToday(Map<String, dynamic> json) {
    final value = json['allowed_tries_today'] ??
        json['allowed_tries'] ??
        json['remaining_tries_today'] ??
        json['remaining_tries'];
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}
