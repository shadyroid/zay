class CreateOrderRequest {
  const CreateOrderRequest({
    required this.lat,
    required this.lng,
    required this.address,
    required this.cityId,
    required this.phone,
    required this.recipientName,
    required this.paymentMethod,
    this.notes,
    this.couponCode,
  });

  final double lat;
  final double lng;
  final String address;
  final int cityId;
  final String phone;
  final String recipientName;
  final String paymentMethod;
  final String? notes;
  final String? couponCode;
}
