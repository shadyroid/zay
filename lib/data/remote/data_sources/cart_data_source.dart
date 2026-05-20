import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';

class CartDataSource {
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestCart() => _remote.post(
        Constants.cartPath,
        dummyJson: DummyJson.cart(),
      );

  Future<Map<String, dynamic>> requestRemoveFromCart({
    required String productId,
  }) =>
      _remote.post(
        Constants.removeFromCartPath,
        variables: {'productId': productId},
        dummyJson: DummyJson.removeFromCart(productId),
      );

  Future<Map<String, dynamic>> requestCheckout() => _remote.post(
        Constants.checkoutPath,
        dummyJson: DummyJson.checkout(),
      );
}
