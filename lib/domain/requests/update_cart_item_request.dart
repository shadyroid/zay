class UpdateCartItemRequest {
  const UpdateCartItemRequest({
    required this.cartItemId,
    required this.quantity,
  });

  final String cartItemId;
  final int quantity;
}
