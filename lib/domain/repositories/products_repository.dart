import 'package:hedma/domain/models/responses/product_response.dart';
import 'package:hedma/domain/models/responses/products_response.dart';

abstract class ProductsRepository {
  Future<ProductsResponse> requestProducts();

  Future<ProductsResponse> requestFeaturedProducts();

  Future<ProductResponse> requestProductDetails({required String productId});

  Future<ProductsResponse> requestFavorites();
}
