class OrderReturnRequest {
  const OrderReturnRequest({
    required this.orderId,
    required this.reason,
    required this.description,
  });

  final String orderId;
  final String reason;
  final String description;
}
