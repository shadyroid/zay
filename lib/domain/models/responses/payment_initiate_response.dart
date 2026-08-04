import 'package:zay/domain/models/responses/base_response.dart';

class PaymentInitiateResponse extends BaseResponse {
  final int? orderId;
  final String? orderNumber;
  final String? paymentUrl;
  final String? paymentStatus;
  final String? transactionId;

  const PaymentInitiateResponse({
    required super.statusCode,
    super.message,
    this.orderId,
    this.orderNumber,
    this.paymentUrl,
    this.paymentStatus,
    this.transactionId,
  });

  factory PaymentInitiateResponse.fromJson(Map<String, dynamic> json) {
    final success = json['success'];
    final statusCode = json['statusCode'] as int? ?? 200;
    final resolvedStatus = success == false && statusCode >= 200 && statusCode < 300
        ? 400
        : statusCode;

    return PaymentInitiateResponse(
      statusCode: resolvedStatus,
      message: json['message'] as String?,
      orderId: json['order_id'] as int?,
      orderNumber: json['order_number'] as String?,
      paymentUrl: json['payment_url'] as String?,
      paymentStatus: json['payment_status'] as String?,
      transactionId: json['transaction_id'] as String?,
    );
  }
}
