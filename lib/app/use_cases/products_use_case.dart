import 'package:get/get.dart';
import 'package:hedma/data/repositories/products_repository_impl.dart';
import 'package:hedma/domain/models/responses/product_response.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/repositories/products_repository.dart';

class ProductsUseCase {
  final ProductsRepository _productsRepository =
      Get.put(ProductsRepositoryImpl());

  Future<ProductsResponse> requestProducts() =>
      _productsRepository.requestProducts();

  Future<ProductsResponse> requestFeaturedProducts() =>
      _productsRepository.requestFeaturedProducts();

  Future<ProductResponse> requestProductDetails({required String productId}) =>
      _productsRepository.requestProductDetails(productId: productId);

  Future<ProductsResponse> requestFavorites() =>
      _productsRepository.requestFavorites();
}
