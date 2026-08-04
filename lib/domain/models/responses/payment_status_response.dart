import 'package:zay/domain/models/responses/base_response.dart';

class PaymentStatusResponse extends BaseResponse {
  final int? orderId;
  final String? orderNumber;
  final String? paymentStatus;
  final String? paymentStatusLabel;
  final String? transactionId;
  final String? total;
  final String? capturedAt;
  final String? voidedAt;

  const PaymentStatusResponse({
    required super.statusCode,
    super.message,
    this.orderId,
    this.orderNumber,
    this.paymentStatus,
    this.paymentStatusLabel,
    this.transactionId,
    this.total,
    this.capturedAt,
    this.voidedAt,
  });

  bool get isPending {
    final value = paymentStatus?.toLowerCase();
    return value == null || value == 'pending';
  }

  bool get isPaid {
    final value = paymentStatus?.toLowerCase();
    return value == 'paid' || value == 'captured' || value == 'success';
  }

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    return PaymentStatusResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'] as String?,
      orderId: json['order_id'] as int?,
      orderNumber: json['order_number'] as String?,
      paymentStatus: json['payment_status'] as String?,
      paymentStatusLabel: json['payment_status_label'] as String?,
      transactionId: json['transaction_id'] as String?,
      total: json['total']?.toString(),
      capturedAt: json['captured_at'] as String?,
      voidedAt: json['voided_at'] as String?,
    );
  }
}
