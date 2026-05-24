import 'package:hedma/data/remote/data_sources/reviews_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/reviews_response.dart';
import 'package:hedma/domain/repositories/reviews_repository.dart';
import 'package:hedma/domain/requests/add_order_review_request.dart';
import 'package:hedma/domain/requests/add_try_out_review_request.dart';
import 'package:hedma/domain/requests/reviews_request.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsDataSource _reviewsDataSource = ReviewsDataSource();

  @override
  Future<ReviewsResponse> requestReviews(ReviewsRequest request) async {
    final json = await _reviewsDataSource.requestReviews(request);
    return ReviewsResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestAddTryOutReview(
    AddTryOutReviewRequest request,
  ) async {
    final json = await _reviewsDataSource.requestAddTryOutReview(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestAddOrderReview(
    AddOrderReviewRequest request,
  ) async {
    final json = await _reviewsDataSource.requestAddOrderReview(request);
    return BaseResponse.fromJson(json);
  }
}
