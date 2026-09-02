class SummaryRequest {
  const SummaryRequest({
    required this.cityId,
    this.paymentMethod,
  });

  final int cityId;
  final String? paymentMethod;
}
