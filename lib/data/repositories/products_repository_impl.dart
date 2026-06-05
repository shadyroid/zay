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

  void _syncProductsFromResponse(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic> && data['products'] is List) {
      LikesUtil.syncProductsFromList(data['products'] as List);
    } else if (json['products'] is List) {
      LikesUtil.syncProductsFromList(json['products'] as List);
    } else if (data is List) {
      LikesUtil.syncProductsFromList(data);
    } else if (json['wishlist'] is List) {
      LikesUtil.syncProductsFromList(json['wishlist'] as List);
    }

    if (json['product'] is Map) {
      LikesUtil.syncProductFromJson(
        Map<String, dynamic>.from(json['product'] as Map),
      );
    }

    if (json['similar_products'] is List) {
      LikesUtil.syncProductsFromList(json['similar_products'] as List);
    }
  }

  @override
  Future<CategoriesResponse> requestCategories() async {
    final json = await _productsDataSource.requestCategories();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return CategoriesResponse.fromJson(json);
    }
    return CategoriesResponse.fromJson({...json, 'data': json['categories']});
  }

  @override
  Future<SizesResponse> requestSizes() async {
    final json = await _productsDataSource.requestSizes();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return SizesResponse.fromJson(json);
    }
    return SizesResponse.fromJson({...json, 'data': json['sizes']});
  }

  @override
  Future<ProductsResponse> requestProducts({
    ProductsRequest request = const ProductsRequest(),
  }) async {
    var json = await _productsDataSource.requestProducts(request: request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ProductsResponse.fromJson(json);
    }
    json = {
      "statusCode": json['statusCode'],
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
    final json = await _productsDataSource.requestProductDetails(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ProductResponse.fromJson(json);
    }
    _syncProductsFromResponse(json);
    return ProductResponse.fromJson({
      ...json,
      'data': json['product'] is Map
          ? Map<String, dynamic>.from(json['product'] as Map)
          : null,
      if (json['similar_products'] is List)
        'similarProducts': json['similar_products'],
    });
  }

  @override
  Future<ProductsResponse> requestFavorites() async {
    var json = await _productsDataSource.requestFavorites();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ProductsResponse.fromJson(json);
    }
    json = {
      "statusCode": json['statusCode'],
      "data": json['wishlist'].map((entry) => entry['product']).toList(),
    };

    LikesUtil.syncProductsFromList(json['data']);
    return ProductsResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestFavorite(ProductIdRequest request) async {
    final json = await _productsDataSource.requestFavorite(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    LikesUtil.productLike(request.productId, isFavorite: true);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestUnFavorite(ProductIdRequest request) async {
    final json = await _productsDataSource.requestUnFavorite(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    LikesUtil.productLike(request.productId, isFavorite: false);
    return BaseResponse.fromJson(json);
  }

  @override
  Future<TryProductResponse> requestTryProduct(
    TryProductRequest request,
  ) async {
    final json = await _productsDataSource.requestTryProduct(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return TryProductResponse.fromJson(json);
    }
    return TryProductResponse.fromJson(json);
  }
}
