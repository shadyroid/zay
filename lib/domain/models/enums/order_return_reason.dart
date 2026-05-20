enum OrderReturnReason {
  wrongSize,
  productProblem;

  String get translationKey => switch (this) {
        OrderReturnReason.wrongSize => 'returnReasonWrongSize',
        OrderReturnReason.productProblem => 'returnReasonProductProblem',
      };
}
