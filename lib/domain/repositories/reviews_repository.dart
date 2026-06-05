import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/reviews_response.dart';
import 'package:hedma/domain/requests/add_review_request.dart';
import 'package:hedma/domain/requests/reviews_request.dart';
import 'package:hedma/domain/requests/try_on_review_request.dart';

abstract class ReviewsRepository {
  Future<ReviewsResponse> requestReviews(ReviewsRequest request);

  Future<BaseResponse> requestAddReview(AddReviewRequest request);

  Future<BaseResponse> requestTryOnReview(TryOnReviewRequest request);

}
