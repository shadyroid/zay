import 'package:hedma/data/remote/data_sources/reviews_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/reviews_response.dart';
import 'package:hedma/domain/repositories/reviews_repository.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsDataSource _reviewsDataSource = ReviewsDataSource();

  @override
  Future<ReviewsResponse> requestReviews({required String productId}) async {
    final json = await _reviewsDataSource.requestReviews(productId: productId);
    return ReviewsResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestAddReview({
    required String productId,
    required String title,
    required String comment,
    required double rating,
  }) async {
    final json = await _reviewsDataSource.requestAddReview(
      productId: productId,
      title: title,
      comment: comment,
      rating: rating,
    );
    return BaseResponse.fromJson(json);
  }
}
