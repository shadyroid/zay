import 'package:zay/domain/models/beans/coupon_bean.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class ValidateCouponResponse extends BaseResponse {
  final CouponBean? coupon;

  const ValidateCouponResponse({
    required super.statusCode,
    super.message,
    this.coupon,
  });

  factory ValidateCouponResponse.fromJson(Map<String, dynamic> json) {
    final success = json['success'];
    final statusCode = json['statusCode'] as int? ?? 200;
    final resolvedStatus =
        success == false && statusCode >= 200 && statusCode < 300
            ? 400
            : statusCode;

    final couponJson = json['coupon'] ?? json['data'];

    return ValidateCouponResponse(
      statusCode: resolvedStatus,
      message: json['message'] as String?,
      coupon: couponJson is Map
          ? CouponBean.fromJson(Map<String, dynamic>.from(couponJson))
          : null,
    );
  }
}
