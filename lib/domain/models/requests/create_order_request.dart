class CreateOrderRequest {
  const CreateOrderRequest({
    required this.lat,
    required this.lng,
    required this.address,
    required this.city,
    required this.area,
    required this.phone,
    required this.recipientName,
    required this.paymentMethod,
    this.notes,
  });

  final double lat;
  final double lng;
  final String address;
  final String city;
  final String area;
  final String phone;
  final String recipientName;
  final String paymentMethod;
  final String? notes;
}
