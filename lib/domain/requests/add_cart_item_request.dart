class AddCartItemRequest {
  const AddCartItemRequest({
    required this.productId,
    required this.productSizeId,
    required this.quantity,
  });

  final String productId;
  final String productSizeId;
  final int quantity;
}
