enum PaymentMethod {
  cash,
  card,
}

extension PaymentMethodX on PaymentMethod {
  String get apiValue => switch (this) {
        PaymentMethod.cash => 'cash_on_delivery',
        PaymentMethod.card => 'card',
      };
}
