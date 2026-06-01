import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/reviews_response.dart';
import 'package:hedma/domain/requests/add_review_request.dart';
import 'package:hedma/domain/requests/add_try_out_review_request.dart';
import 'package:hedma/domain/requests/reviews_request.dart';

abstract class ReviewsRepository {
  Future<ReviewsResponse> requestReviews(ReviewsRequest request);

  Future<BaseResponse> requestAddTryOutReview(AddTryOutReviewRequest request);

  Future<BaseResponse> requestAddReview(AddReviewRequest request);
}
