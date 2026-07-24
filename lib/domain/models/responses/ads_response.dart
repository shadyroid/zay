import 'package:zay/domain/models/beans/ad_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class AdsResponse extends BaseResponse {
  final List<AdBean>? data;

  const AdsResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory AdsResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return AdsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: list
          ?.map((e) => AdBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
