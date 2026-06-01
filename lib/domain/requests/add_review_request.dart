import 'package:hedma/domain/models/enums/review_size_fit.dart';

class AddReviewRequest {
  const AddReviewRequest({
    required this.productId,
    required this.orderItemId,
    required this.sizeFit,
    required this.rating,
    this.comment,
  });

  final String productId;
  final String orderItemId;
  final ReviewSizeFit sizeFit;
  final int rating;
  final String? comment;
}
