import 'package:hedma/domain/models/beans/return_reason_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class ReturnReasonsResponse extends BaseResponse {
  final List<ReturnReasonBean>? data;
  final String? returnPolicy;
  final int? returnWindowDays;

  const ReturnReasonsResponse({
    required super.statusCode,
    super.message,
    this.data,
    this.returnPolicy,
    this.returnWindowDays,
  });

  factory ReturnReasonsResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return ReturnReasonsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: list
          ?.map((e) => ReturnReasonBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      returnPolicy: json['returnPolicy'] as String?,
      returnWindowDays: json['returnWindowDays'] as int?,
    );
  }
}
