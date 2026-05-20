import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';

class ProductsDataSource {
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestProducts() => _remote.post(
        Constants.productsPath,
        dummyJson: DummyJson.products(),
      );

  Future<Map<String, dynamic>> requestFeaturedProducts() => _remote.post(
        Constants.featuredProductsPath,
        dummyJson: DummyJson.featuredProducts(),
      );

  Future<Map<String, dynamic>> requestProductDetails({
    required String productId,
  }) =>
      _remote.post(
        Constants.productDetailsPath,
        variables: {'productId': productId},
        dummyJson: DummyJson.productDetails(productId),
      );

  Future<Map<String, dynamic>> requestFavorites() => _remote.post(
        Constants.favoritesPath,
        dummyJson: DummyJson.favorites(),
      );
}
