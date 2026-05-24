import 'package:hedma/data/remote/data_sources/products_data_source.dart';
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

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDataSource _productsDataSource = ProductsDataSource();

  @override
  Future<CategoriesResponse> requestCategories() async {
    final json = await _productsDataSource.requestCategories();
    return CategoriesResponse.fromJson(json);
  }

  @override
  Future<SizesResponse> requestSizes() async {
    final json = await _productsDataSource.requestSizes();
    return SizesResponse.fromJson(json);
  }

  @override
  Future<ProductsResponse> requestProducts({
    ProductsRequest request = const ProductsRequest(),
  }) async {
    final json = await _productsDataSource.requestProducts(request: request);
    return ProductsResponse.fromJson(json);
  }

  @override
  Future<ProductResponse> requestProductDetails(
    ProductDetailsRequest request,
  ) async {
    final json = await _productsDataSource.requestProductDetails(request);
    return ProductResponse.fromJson(json);
  }

  @override
  Future<ProductsResponse> requestFavorites() async {
    final json = await _productsDataSource.requestFavorites();
    return ProductsResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestFavorite(ProductIdRequest request) async {
    final json = await _productsDataSource.requestFavorite(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestUnFavorite(ProductIdRequest request) async {
    final json = await _productsDataSource.requestUnFavorite(request);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<TryProductResponse> requestTryProduct(TryProductRequest request) async {
    final json = await _productsDataSource.requestTryProduct(request);
    return TryProductResponse.fromJson(json);
  }
}
