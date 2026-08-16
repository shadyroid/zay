import 'package:zay/app/utils/parser.dart';

class CouponBean {
  final String code;
  final String type;
  final double value;
  final double discountAmount;
  final double subtotalAfterDiscount;
  final String? description;

  const CouponBean({
    required this.code,
    required this.type,
    required this.value,
    required this.discountAmount,
    required this.subtotalAfterDiscount,
    this.description,
  });

  factory CouponBean.fromJson(Map<String, dynamic> json) {
    return CouponBean(
      code: json['code'] as String? ?? '',
      type: json['type'] as String? ?? '',
      value: Parser.parseDouble(json['value']) ?? 0,
      discountAmount: Parser.parseDouble(json['discount_amount']) ?? 0,
      subtotalAfterDiscount:
          Parser.parseDouble(json['subtotal_after_discount']) ?? 0,
      description: json['description'] as String?,
    );
  }
}
