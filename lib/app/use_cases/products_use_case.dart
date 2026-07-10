import 'package:get/get.dart';
import 'package:zay/data/repositories/products_repository_impl.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/categories_response.dart';
import 'package:zay/domain/models/responses/product_response.dart';
import 'package:zay/domain/models/responses/products_response.dart';
import 'package:zay/domain/models/responses/sizes_response.dart';
import 'package:zay/domain/models/responses/try_on_response.dart';
import 'package:zay/domain/repositories/products_repository.dart';
import 'package:zay/domain/requests/product_details_request.dart';
import 'package:zay/domain/requests/product_id_request.dart';
import 'package:zay/domain/requests/products_request.dart';
import 'package:zay/domain/requests/try_on_request.dart';

class ProductsUseCase {
  final ProductsRepository _productsRepository = Get.put(
    ProductsRepositoryImpl(),
  );

  Future<CategoriesResponse> requestCategories() =>
      _productsRepository.requestCategories();

  Future<SizesResponse> requestSizes() => _productsRepository.requestSizes();

  Future<ProductsResponse> requestProducts(ProductsRequest request) => _productsRepository.requestProducts(request);

  Future<ProductResponse> requestProductDetails(
    ProductDetailsRequest request,
  ) => _productsRepository.requestProductDetails(request);

  Future<ProductsResponse> requestFavorites() =>
      _productsRepository.requestFavorites();

  Future<BaseResponse> requestFavorite(ProductIdRequest request) =>
      _productsRepository.requestFavorite(request);

  Future<BaseResponse> requestUnFavorite(ProductIdRequest request) =>
      _productsRepository.requestUnFavorite(request);

  Future<TryOnResponse> requestTryOn(TryOnRequest request) =>
      _productsRepository.requestTryOn(request);
}
