class TryProductRequest {
  const TryProductRequest({
    required this.productId,
    required this.imagePath,
  });

  final int? productId;
  final String imagePath;
}
