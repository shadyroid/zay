class SummaryRequest {
  const SummaryRequest({
    required this.lat,
    required this.lng,
    required this.address,
    required this.city,
    required this.area,
    required this.paymentMethod,
  });

  final double lat;
  final double lng;
  final String address;
  final String city;
  final String area;
  final String paymentMethod;
}
