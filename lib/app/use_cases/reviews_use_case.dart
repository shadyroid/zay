import 'package:get/get.dart';
import 'package:hedma/data/repositories/reviews_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/reviews_response.dart';
import 'package:hedma/domain/repositories/reviews_repository.dart';

class ReviewsUseCase {
  final ReviewsRepository _reviewsRepository = Get.put(ReviewsRepositoryImpl());

  Future<ReviewsResponse> requestReviews({required String productId}) =>
      _reviewsRepository.requestReviews(productId: productId);

  Future<BaseResponse> requestAddReview({
    required String productId,
    required String title,
    required String comment,
    required double rating,
  }) =>
      _reviewsRepository.requestAddReview(
        productId: productId,
        title: title,
        comment: comment,
        rating: rating,
      );
}
