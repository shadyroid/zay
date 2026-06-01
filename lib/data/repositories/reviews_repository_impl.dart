import 'package:hedma/data/remote/data_sources/reviews_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/reviews_response.dart';
import 'package:hedma/domain/repositories/reviews_repository.dart';
import 'package:hedma/domain/requests/add_review_request.dart';
import 'package:hedma/domain/requests/add_try_out_review_request.dart';
import 'package:hedma/domain/requests/reviews_request.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsDataSource _reviewsDataSource = ReviewsDataSource();

  @override
  Future<ReviewsResponse> requestReviews(ReviewsRequest request) async {
    final json = await _reviewsDataSource.requestReviews(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ReviewsResponse.fromJson(json);
    }
    return ReviewsResponse.fromJson({
      ...json,
      'data': json['reviews'],
    });
  }

  @override
  Future<BaseResponse> requestAddTryOutReview(
    AddTryOutReviewRequest request,
  ) async {
    final json = await _reviewsDataSource.requestAddTryOutReview(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestAddReview(AddReviewRequest request) async {
    final json = await _reviewsDataSource.requestAddReview(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }
}
