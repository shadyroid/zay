import 'package:zay/domain/models/enums/payment_status.dart';
import 'package:zay/domain/models/responses/base_response.dart';

class PaymentStatusResponse extends BaseResponse {
  final int? orderId;
  final String? orderNumber;
  final PaymentStatus paymentStatus;
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
    this.paymentStatus = PaymentStatus.pending,
    this.paymentStatusLabel,
    this.transactionId,
    this.total,
    this.capturedAt,
    this.voidedAt,
  });

  bool get isPending => paymentStatus.isPending;

  bool get isPaid => paymentStatus.isPaid;

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    return PaymentStatusResponse(
      statusCode: json['statusCode'] as int? ?? 200,
      message: json['message'] as String?,
      orderId: json['order_id'] as int?,
      orderNumber: json['order_number'] as String?,
      paymentStatus: PaymentStatus.fromApi(json['payment_status']?.toString()),
      paymentStatusLabel: json['payment_status_label'] as String?,
      transactionId: json['transaction_id'] as String?,
      total: json['total']?.toString(),
      capturedAt: json['captured_at'] as String?,
      voidedAt: json['voided_at'] as String?,
    );
  }
}
