import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dummy/dummy_json.dart';
import 'package:hedma/data/remote/dummy/remote_post.dart';

class ProductsDataSource {
  final RemotePost _remote = RemotePost.find;

  Future<Map<String, dynamic>> requestCategories() => _remote.post(
        Constants.categoriesPath,
        dummyJson: DummyJson.categories(),
      );

  Future<Map<String, dynamic>> requestSizes() => _remote.post(
        Constants.sizesPath,
        dummyJson: DummyJson.sizes(),
      );

  Future<Map<String, dynamic>> requestProducts({String? categoryId}) =>
      _remote.post(
        Constants.productsPath,
        variables: categoryId == null ? null : {'categoryId': categoryId},
        dummyJson: DummyJson.products(categoryId: categoryId),
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

  Future<Map<String, dynamic>> requestFavorite({required String productId}) =>
      _remote.post(
        Constants.favoritePath,
        variables: {'productId': productId},
        dummyJson: DummyJson.favorite(productId),
      );

  Future<Map<String, dynamic>> requestUnFavorite({required String productId}) =>
      _remote.post(
        Constants.unfavoritePath,
        variables: {'productId': productId},
        dummyJson: DummyJson.unfavorite(productId),
      );
}
