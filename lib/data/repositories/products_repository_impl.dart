import 'dart:developer';

import 'package:hedma/app/utils/likes_util.dart';
import 'package:hedma/data/preferences/prefs_manager.dart';
import 'package:hedma/data/remote/data_sources/cart_data_source.dart';
import 'package:hedma/data/remote/data_sources/products_data_source.dart';
import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/categories_response.dart';
import 'package:hedma/domain/models/responses/product_response.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/sizes_response.dart';
import 'package:hedma/domain/models/responses/try_on_response.dart';
import 'package:hedma/domain/repositories/products_repository.dart';
import 'package:hedma/domain/requests/product_details_request.dart';
import 'package:hedma/domain/requests/product_id_request.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/domain/requests/try_on_request.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDataSource _productsDataSource = ProductsDataSource();
  final CartDataSource _cartDataSource = CartDataSource();

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
    if (json['statusCode'] == 200) {
      final images = json['product']?['images'];
      json['product']['primary_image'] = images.firstWhere(
        (e) => e['is_primary'] == true,
        orElse: () => images.first,
      )['url'];
      json['product']['images'] = images.map((e) => e['url']).toList();
      if (PrefsManager.isLoggedIn) {
        var cartJson = await _cartDataSource.requestCart();
        if (cartJson['statusCode'] == 200) {
          final Map<int, int> result = {};
          final shops = cartJson['items'];
          for (final shopData in shops) {
            final shop = shopData['shop'];
            if (shop['id'] != json['product']?['shop']?['id']) continue;

            final items = shopData['items'] as List<dynamic>;

            for (final item in items) {
              final product = item['product'];

              if (product['id'] != json['product']?['id']) continue;

              final sizeId = item['size']['id'];
              final quantity = item['quantity'];

              if (sizeId != null) result[sizeId] = quantity;
            }
          }
          log("message ${result}");
          json['product']['selectedSizesQuantities'] = result;
        }
      }
    }

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
  Future<TryOnResponse> requestTryOn(
    TryOnRequest request,
  ) async {
    final json = await _productsDataSource.requestTryOn(request);
    return TryOnResponse.fromJson(json);
  }
}
