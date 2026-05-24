import 'package:hedma/domain/models/enums/review_size_fit.dart';

class AddOrderReviewRequest {
  const AddOrderReviewRequest({
    required this.orderId,
    required this.sizeFit,
    required this.rating,
    this.comment,
  });

  final String orderId;
  final ReviewSizeFit sizeFit;
  final double rating;
  final String? comment;
}
