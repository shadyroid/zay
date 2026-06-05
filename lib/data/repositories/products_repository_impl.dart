import 'package:hedma/app/utils/likes_util.dart';
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
    var json = await _productsDataSource.requestCategories();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['categories'],
    };
    return CategoriesResponse.fromJson(json);
  }

  @override
  Future<SizesResponse> requestSizes() async {
    var json = await _productsDataSource.requestSizes();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['sizes'],
    };
    return SizesResponse.fromJson(json);
  }

  @override
  Future<ProductsResponse> requestProducts(ProductsRequest request) async {
    var json = await _productsDataSource.requestProducts(request);
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['products'],
      "totalCount": json['pagination']?['total'],
    };
    LikesUtil.syncProductsFromList(json['data']);

    return ProductsResponse.fromJson(json);
  }

  @override
  Future<ProductResponse> requestProductDetails(
    ProductDetailsRequest request,
  ) async {
    var json = await _productsDataSource.requestProductDetails(request);
    final images = json['product']?['images'];
    json['product']['primary_image'] = images.firstWhere(
      (e) => e['is_primary'] == true,
      orElse: () => images.first,
    )['url'];
    json['product']['images'] = images.map((e) => e['url']).toList();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['product'],
    };
    LikesUtil.syncProductFromJson(json['data']);
    return ProductResponse.fromJson(json);
  }

  @override
  Future<ProductsResponse> requestFavorites() async {
    var json = await _productsDataSource.requestFavorites();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['wishlist'].map((entry) => entry['product']).toList(),
    };

    LikesUtil.syncProductsFromList(json['data']);
    return ProductsResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestFavorite(ProductIdRequest request) async {
    var json = await _productsDataSource.requestFavorite(request);
    LikesUtil.productLike(request.productId, isFavorite: true);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestUnFavorite(ProductIdRequest request) async {
    final json = await _productsDataSource.requestUnFavorite(request);
    LikesUtil.productLike(request.productId, isFavorite: false);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<TryProductResponse> requestTryProduct(
    TryProductRequest request,
  ) async {
    final json = await _productsDataSource.requestTryProduct(request);
    return TryProductResponse.fromJson(json);
  }
}
