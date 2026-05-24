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
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return CategoriesResponse.fromJson(json);
    }
    return CategoriesResponse.fromJson({
      ...json,
      'data': json['categories'],
    });
  }

  @override
  Future<SizesResponse> requestSizes() async {
    final json = await _productsDataSource.requestSizes();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return SizesResponse.fromJson(json);
    }
    return SizesResponse.fromJson({
      ...json,
      'data': json['sizes'],
    });
  }

  @override
  Future<ProductsResponse> requestProducts({
    ProductsRequest request = const ProductsRequest(),
  }) async {
    final json = await _productsDataSource.requestProducts(request: request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ProductsResponse.fromJson(json);
    }

    final remapped = <String, dynamic>{...json};
    final data = json['data'];
    if (data is Map<String, dynamic> && data['products'] is List) {
      remapped['data'] = data['products'];
      final pagination = data['pagination'] ?? json['pagination'];
      if (pagination is Map) {
        remapped['totalCount'] = pagination['total'];
      }
    } else if (json['products'] is List) {
      remapped['data'] = json['products'];
      final pagination = json['pagination'];
      if (pagination is Map) {
        remapped['totalCount'] = pagination['total'];
      }
    } else if (data is List) {
      remapped['data'] = data;
    } else if (data is Map<String, dynamic>) {
      remapped['data'] = data;
    }

    return ProductsResponse.fromJson(remapped);
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
    final json = await _productsDataSource.requestFavorites();
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return ProductsResponse.fromJson(json);
    }

    final remapped = <String, dynamic>{
      ...json,
      'data': json['wishlist'],
    };
    final pagination = json['pagination'];
    if (pagination is Map) {
      remapped['totalCount'] = pagination['total'];
    }

    return ProductsResponse.fromJson(remapped);
  }

  @override
  Future<BaseResponse> requestFavorite(ProductIdRequest request) async {
    final json = await _productsDataSource.requestFavorite(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<BaseResponse> requestUnFavorite(ProductIdRequest request) async {
    final json = await _productsDataSource.requestUnFavorite(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return BaseResponse.fromJson(json);
    }
    return BaseResponse.fromJson(json);
  }

  @override
  Future<TryProductResponse> requestTryProduct(TryProductRequest request) async {
    final json = await _productsDataSource.requestTryProduct(request);
    final status = json['statusCode'] as int?;
    if (status != null && status != 200) {
      return TryProductResponse.fromJson(json);
    }
    return TryProductResponse.fromJson(json);
  }
}
