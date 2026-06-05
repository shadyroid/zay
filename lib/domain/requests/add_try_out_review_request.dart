class AddTryOutReviewRequest {
  const AddTryOutReviewRequest({
    required this.productId,
    required this.title,
    required this.comment,
    required this.rating,
  });

  final int? productId;
  final String title;
  final String comment;
  final double rating;
}
