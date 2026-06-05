import 'package:get/get.dart';
import 'package:hedma/data/repositories/reviews_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/reviews_response.dart';
import 'package:hedma/domain/repositories/reviews_repository.dart';
import 'package:hedma/domain/requests/add_review_request.dart';
import 'package:hedma/domain/requests/reviews_request.dart';
import 'package:hedma/domain/requests/try_on_request.dart';
import 'package:hedma/domain/requests/try_on_review_request.dart';

class ReviewsUseCase {
  final ReviewsRepository _reviewsRepository = Get.put(ReviewsRepositoryImpl());

  Future<ReviewsResponse> requestReviews(ReviewsRequest request) =>
      _reviewsRepository.requestReviews(request);


  Future<BaseResponse> requestAddReview(AddReviewRequest request) =>
      _reviewsRepository.requestAddReview(request);
  
  Future<BaseResponse> requestTryOnReview(TryOnReviewRequest request) =>
      _reviewsRepository.requestTryOnReview(request);

}
