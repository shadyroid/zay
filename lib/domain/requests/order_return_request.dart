class OrderReturnRequest {
  const OrderReturnRequest({
    required this.orderId,
    required this.reason,
    required this.description,
  });

  final int orderId;
  final String reason;
  final String description;
}
