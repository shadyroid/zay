import 'package:zay/app/utils/parser.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class SummaryResponse extends BaseResponse {
  final double? shippingFee;

  const SummaryResponse({
    required super.statusCode,
    super.message,
    this.shippingFee,
  });

  factory SummaryResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final Map<String, dynamic>? dataMap =
        data is Map ? Map<String, dynamic>.from(data) : null;

    return SummaryResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'],
      shippingFee: Parser.parseDouble(
            json['shipping_fee'] ??
                dataMap?['shipping_fee'] ??
                json['shippingFee'] ??
                dataMap?['shippingFee'],
          ) ??
          0,
    );
  }
}
