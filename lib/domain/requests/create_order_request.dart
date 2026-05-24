class CreateOrderRequest {
  const CreateOrderRequest({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.mobileNumber,
    required this.paymentMethod,
  });

  final String address;
  final double latitude;
  final double longitude;
  final String mobileNumber;
  final String paymentMethod;
}
