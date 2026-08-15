import 'package:get/get.dart';

enum PaymentMethod {
  cash,
  card,
  unknown;

  static PaymentMethod fromApi(String? value) {
    switch (value?.toLowerCase().trim()) {
      case 'cash_on_delivery':
      case 'cash':
        return PaymentMethod.cash;
      case 'card':
        return PaymentMethod.card;
      default:
        return PaymentMethod.unknown;
    }
  }

  String get apiValue => switch (this) {
        PaymentMethod.cash => 'cash_on_delivery',
        PaymentMethod.card => 'card',
        PaymentMethod.unknown => 'unknown',
      };

  String get labelKey => switch (this) {
        PaymentMethod.cash => 'cashOnDelivery',
        PaymentMethod.card => 'card',
        PaymentMethod.unknown => 'paymentMethod',
      };

  String displayLabel([String? raw]) {
    if (this == PaymentMethod.unknown) return raw?.trim() ?? '';
    return labelKey.tr;
  }
}
