import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';

class ShopsDataSource {
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestShops() => _remote.post(
        Constants.shopsPath,
        dummyJson: DummyJson.shops(),
      );

  Future<Map<String, dynamic>> requestShopDetails({
    required String shopId,
  }) =>
      _remote.post(
        Constants.shopDetailsPath,
        variables: {'shopId': shopId},
        dummyJson: DummyJson.shopDetails(shopId),
      );

  Future<Map<String, dynamic>> requestShopProducts({
    required String shopId,
  }) =>
      _remote.post(
        Constants.shopProductsPath,
        variables: {'shopId': shopId},
        dummyJson: DummyJson.shopProducts(shopId),
      );
}
