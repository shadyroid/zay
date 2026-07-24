import 'package:zay/data/remote/data_sources/reviews_data_source.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/reviews_response.dart';
import 'package:zay/domain/repositories/reviews_repository.dart';
import 'package:zay/domain/models/requests/add_review_request.dart';
import 'package:zay/domain/models/requests/reviews_request.dart';
import 'package:zay/domain/models/requests/try_on_review_request.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsDataSource _reviewsDataSource = ReviewsDataSource();

  @override
  Future<ReviewsResponse> requestReviews(ReviewsRequest request) async {
    var json = await _reviewsDataSource.requestReviews(request);
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['reviews'],
    };
    return ReviewsResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestAddReview(AddReviewRequest request) async {
    final json = await _reviewsDataSource.requestAddReview(request);

    return BaseResponse.fromJson(json);
  }

 @override
  Future<BaseResponse> requestTryOnReview(TryOnReviewRequest request) async {
    final json = await _reviewsDataSource.requestTryOnReview(request);
    return BaseResponse.fromJson(json);
  }



}
