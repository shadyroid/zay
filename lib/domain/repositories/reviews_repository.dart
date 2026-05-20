import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/reviews_response.dart';

abstract class ReviewsRepository {
  Future<ReviewsResponse> requestReviews({required String productId});

  Future<BaseResponse> requestAddReview({
    required String productId,
    required String title,
    required String comment,
    required double rating,
  });
}
