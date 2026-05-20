import 'package:hedma/data/remote/data_sources/products_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/categories_response.dart';
import 'package:hedma/domain/models/responses/product_response.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/sizes_response.dart';
import 'package:hedma/domain/models/responses/try_product_response.dart';
import 'package:hedma/domain/repositories/products_repository.dart';

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
  Future<ProductsResponse> requestProducts({String? categoryId}) async {
    final json =
        await _productsDataSource.requestProducts(categoryId: categoryId);
    return ProductsResponse.fromJson(json);
  }

  @override
  Future<ProductsResponse> requestFeaturedProducts() async {
    final json = await _productsDataSource.requestFeaturedProducts();
    return ProductsResponse.fromJson(json);
  }

  @override
  Future<ProductResponse> requestProductDetails({
    required String productId,
  }) async {
    final json = await _productsDataSource.requestProductDetails(
      productId: productId,
    );
    return ProductResponse.fromJson(json);
  }

  @override
  Future<ProductsResponse> requestFavorites() async {
    final json = await _productsDataSource.requestFavorites();
    return ProductsResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestFavorite({required String productId}) async {
    final json =
        await _productsDataSource.requestFavorite(productId: productId);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestUnFavorite({required String productId}) async {
    final json =
        await _productsDataSource.requestUnFavorite(productId: productId);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<TryProductResponse> requestTryProduct({
    required String productId,
    required String imagePath,
  }) async {
    final json = await _productsDataSource.requestTryProduct(
      productId: productId,
      imagePath: imagePath,
    );
    return TryProductResponse.fromJson(json);
  }
}
