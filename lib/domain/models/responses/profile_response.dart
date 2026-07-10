import 'package:zay/domain/models/beans/user_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class ProfileResponse extends BaseResponse {
  final UserBean? data;

  const ProfileResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: json['data'] != null
          ? UserBean.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
