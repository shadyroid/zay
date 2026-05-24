import 'package:get/get.dart';
import 'package:hedma/data/repositories/products_repository_impl.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/categories_response.dart';
import 'package:hedma/domain/models/responses/product_response.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/sizes_response.dart';
import 'package:hedma/domain/models/responses/try_product_response.dart';
import 'package:hedma/domain/repositories/products_repository.dart';
import 'package:hedma/domain/requests/product_details_request.dart';
import 'package:hedma/domain/requests/product_id_request.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/domain/requests/try_product_request.dart';

class ProductsUseCase {
  final ProductsRepository _productsRepository =
      Get.put(ProductsRepositoryImpl());

  Future<CategoriesResponse> requestCategories() =>
      _productsRepository.requestCategories();

  Future<SizesResponse> requestSizes() => _productsRepository.requestSizes();

  Future<ProductsResponse> requestProducts({
    ProductsRequest request = const ProductsRequest(),
  }) =>
      _productsRepository.requestProducts(request: request);

  Future<ProductResponse> requestProductDetails(
    ProductDetailsRequest request,
  ) =>
      _productsRepository.requestProductDetails(request);

  Future<ProductsResponse> requestFavorites() =>
      _productsRepository.requestFavorites();

  Future<BaseResponse> requestFavorite(ProductIdRequest request) =>
      _productsRepository.requestFavorite(request);

  Future<BaseResponse> requestUnFavorite(ProductIdRequest request) =>
      _productsRepository.requestUnFavorite(request);

  Future<TryProductResponse> requestTryProduct(TryProductRequest request) =>
      _productsRepository.requestTryProduct(request);
}
