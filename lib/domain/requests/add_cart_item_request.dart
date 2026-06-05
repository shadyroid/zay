class AddCartItemRequest {
  const AddCartItemRequest({
    required this.productId,
    required this.productSizeId,
    required this.quantity,
  });

  final int productId;
  final int? productSizeId;
  final int quantity;
}
