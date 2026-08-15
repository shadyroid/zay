enum PaymentStatus {
  pending,
  held,
  paid,
  captured,
  success,
  failed,
  voided,
  unknown;

  static PaymentStatus fromApi(String? value) {
    switch (value?.toLowerCase().trim()) {
      case null:
      case '':
      case 'pending':
        return PaymentStatus.pending;
      case 'held':
        return PaymentStatus.held;
      case 'paid':
        return PaymentStatus.paid;
      case 'captured':
        return PaymentStatus.captured;
      case 'success':
        return PaymentStatus.success;
      case 'failed':
        return PaymentStatus.failed;
      case 'voided':
        return PaymentStatus.voided;
      default:
        return PaymentStatus.unknown;
    }
  }

  String get apiValue => switch (this) {
        PaymentStatus.pending => 'pending',
        PaymentStatus.held => 'held',
        PaymentStatus.paid => 'paid',
        PaymentStatus.captured => 'captured',
        PaymentStatus.success => 'success',
        PaymentStatus.failed => 'failed',
        PaymentStatus.voided => 'voided',
        PaymentStatus.unknown => 'unknown',
      };

  bool get isPaid => switch (this) {
        PaymentStatus.held ||
        PaymentStatus.paid ||
        PaymentStatus.captured ||
        PaymentStatus.success =>
          true,
        _ => false,
      };

  bool get isPending => this == PaymentStatus.pending;
}
