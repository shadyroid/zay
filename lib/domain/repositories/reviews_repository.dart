import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/reviews_response.dart';
import 'package:zay/domain/models/requests/add_review_request.dart';
import 'package:zay/domain/models/requests/reviews_request.dart';
import 'package:zay/domain/models/requests/try_on_review_request.dart';

abstract class ReviewsRepository {
  Future<ReviewsResponse> requestReviews(ReviewsRequest request);

  Future<BaseResponse> requestAddReview(AddReviewRequest request);

  Future<BaseResponse> requestTryOnReview(TryOnReviewRequest request);

}
