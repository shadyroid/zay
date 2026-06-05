class BaseResponse {
  final String? message;
  final int statusCode;

  const BaseResponse({
    this.message,
    required this.statusCode,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json['message'],
      statusCode: json['statusCode'] as int? ?? 200,
    );
  }
}
