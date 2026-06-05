import 'package:hedma/domain/models/beans/review_bean.dart';
import 'package:hedma/domain/models/responses/base_response.dart';

class ReviewsResponse extends BaseResponse {
  final List<ReviewBean>? data;

  const ReviewsResponse({
    required super.statusCode,
    super.message,
    this.data,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>?;
    return ReviewsResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      data: list
          ?.map((e) => ReviewBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
