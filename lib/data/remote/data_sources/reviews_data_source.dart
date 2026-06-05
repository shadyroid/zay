import 'package:get/get.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dio_client.dart';
import 'package:hedma/domain/models/enums/review_size_fit.dart';
import 'package:hedma/domain/requests/add_review_request.dart';
import 'package:hedma/domain/requests/reviews_request.dart';
import 'package:hedma/domain/requests/try_on_review_request.dart';

class ReviewsDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestReviews(ReviewsRequest request) async {
    final response = await _dioClient.get(
      '${Constants.reviewsPath}/${request.productId}/reviews',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }


  Future<Map<String, dynamic>> requestAddReview(
    AddReviewRequest request,
  ) async {
    final response = await _dioClient.post(
      '${Constants.reviewsPath}/${request.productId}/reviews',
      data: {
        'order_item_id': request.orderItemId,
        'rating': request.rating,
        'comment': request.comment?.trim() ?? '',
        'size_rating': request.sizeFit.apiValue,
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestTryOnReview(
    TryOnReviewRequest request,
  ) async {
    final response = await _dioClient.post(
      '${Constants.tryOnReviewPath}/${request.tryOnId}/review',
      data: {'rating': request.rate},
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
