class UpdateCartItemRequest {
  const UpdateCartItemRequest({
    required this.cartItemId,
    required this.quantity,
  });

  final int cartItemId;
  final int quantity;
}
