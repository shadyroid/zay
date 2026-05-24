import 'package:hedma/domain/models/beans/auth_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class SignInResponse extends BaseResponse {
  final AuthBean? data;

  const SignInResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'] as String?,
      data: json['data'] != null
          ? AuthBean.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
