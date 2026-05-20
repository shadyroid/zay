import 'package:get/get.dart';
import 'package:hedma/data/repositories/products_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/categories_response.dart';
import 'package:hedma/domain/models/responses/product_response.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/sizes_response.dart';
import 'package:hedma/domain/repositories/products_repository.dart';

class ProductsUseCase {
  final ProductsRepository _productsRepository =
      Get.put(ProductsRepositoryImpl());

  Future<CategoriesResponse> requestCategories() =>
      _productsRepository.requestCategories();

  Future<SizesResponse> requestSizes() => _productsRepository.requestSizes();

  Future<ProductsResponse> requestProducts({String? categoryId}) =>
      _productsRepository.requestProducts(categoryId: categoryId);

  Future<ProductsResponse> requestFeaturedProducts() =>
      _productsRepository.requestFeaturedProducts();

  Future<ProductResponse> requestProductDetails({required String productId}) =>
      _productsRepository.requestProductDetails(productId: productId);

  Future<ProductsResponse> requestFavorites() =>
      _productsRepository.requestFavorites();

  Future<BaseResponse> requestFavorite({required String productId}) =>
      _productsRepository.requestFavorite(productId: productId);

  Future<BaseResponse> requestUnFavorite({required String productId}) =>
      _productsRepository.requestUnFavorite(productId: productId);
}
