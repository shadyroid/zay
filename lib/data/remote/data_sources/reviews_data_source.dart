import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';

class ReviewsDataSource {
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestReviews({
    required String productId,
  }) =>
      _remote.post(
        Constants.reviewsPath,
        variables: {'productId': productId},
        dummyJson: DummyJson.reviews(productId),
      );

  Future<Map<String, dynamic>> requestAddReview({
    required String productId,
    required String title,
    required String comment,
    required double rating,
  }) =>
      _remote.post(
        Constants.addReviewPath,
        variables: {
          'productId': productId,
          'title': title,
          'comment': comment,
          'rating': rating,
        },
        dummyJson: DummyJson.addReview(productId),
      );
}
