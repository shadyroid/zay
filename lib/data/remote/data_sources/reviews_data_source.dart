import 'package:get/get.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dio_client.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';
import 'package:hedma/domain/models/enums/review_size_fit.dart';
import 'package:hedma/domain/requests/add_order_review_request.dart';
import 'package:hedma/domain/requests/add_try_out_review_request.dart';
import 'package:hedma/domain/requests/reviews_request.dart';

class ReviewsDataSource {
  final DioClient _dioClient = Get.find<DioClient>();
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestReviews(ReviewsRequest request) async {
    final response = await _dioClient.get(
      '${Constants.reviewsPath}/${request.productId}/reviews',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestAddTryOutReview(
    AddTryOutReviewRequest request,
  ) =>
      _remote.post(
        Constants.addTryOutReviewPath,
        variables: {
          'productId': request.productId,
          'title': request.title,
          'comment': request.comment,
          'rating': request.rating,
        },
        dummyJson: DummyJson.addTryOutReview(request.productId),
      );

  Future<Map<String, dynamic>> requestAddOrderReview(
    AddOrderReviewRequest request,
  ) async {
    final response = await _dioClient.postForm(
      '${Constants.orderDetailsPath}/${request.orderId}/reviews',
      fields: {
        'size_fit': request.sizeFit.apiValue,
        'rating': request.rating,
        if (request.comment != null && request.comment!.trim().isNotEmpty)
          'comment': request.comment!.trim(),
      },
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
