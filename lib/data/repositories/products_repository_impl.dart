import 'dart:developer';

import 'package:zay/app/utils/likes_util.dart';
import 'package:zay/app/utils/transfer_progress.dart';
import 'package:zay/data/preferences/prefs_manager.dart';
import 'package:zay/data/remote/data_sources/cart_data_source.dart';
import 'package:zay/data/remote/data_sources/products_data_source.dart';
import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/categories_response.dart';
import 'package:zay/domain/models/responses/product_response.dart';
import 'package:zay/domain/models/responses/products_response.dart';
import 'package:zay/domain/models/responses/sizes_response.dart';
import 'package:zay/domain/models/responses/try_on_response.dart';
import 'package:zay/domain/models/responses/types_response.dart';
import 'package:zay/domain/repositories/products_repository.dart';
import 'package:zay/domain/models/requests/product_details_request.dart';
import 'package:zay/domain/models/requests/product_id_request.dart';
import 'package:zay/domain/models/requests/products_request.dart';
import 'package:zay/domain/models/requests/try_on_request.dart';
import 'package:get/get.dart';

class ProductsRepositoryImpl implements ProductsRepository {
 final ProductsDataSource _productsDataSource = Get.put(ProductsDataSource());
 final CartDataSource _cartDataSource = Get.put(CartDataSource());

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
  Future<TypesResponse> requestTryOnCategories() async {
    var json = await _productsDataSource.requestTryOnCategories();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['categories'],
    };
    return TypesResponse.fromJson(json);
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
  Future<ProductsResponse> requestProducts(
    ProductsRequest request, {
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onReceiveProgress,
  }) async {
    var json = await _withFakeReceiveProgress(
      duration: const Duration(seconds: 40),
      enabled: request.image != null && onReceiveProgress != null,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      request: (onSend, onReceive) => _productsDataSource.requestProducts(
        request,
        onSendProgress: onSend,
        onReceiveProgress: onReceive,
      ),
    );

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
    TryOnRequest request, {
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onReceiveProgress,
  }) async {
    final json = await _withFakeReceiveProgress(
      duration: const Duration(seconds: 50),
      enabled: onReceiveProgress != null,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      request: (onSend, onReceive) => _productsDataSource.requestTryOn(
        request,
        onSendProgress: onSend,
        onReceiveProgress: onReceive,
      ),
    );
    return TryOnResponse.fromJson(json);
  }

  Future<T> _withFakeReceiveProgress<T>({
    required Duration duration,
    required bool enabled,
    required Future<T> Function(
      void Function(int count, int total)? onSendProgress,
      void Function(int count, int total)? onReceiveProgress,
    ) request,
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onReceiveProgress,
  }) async {
    if (!enabled) {
      return request(onSendProgress, onReceiveProgress);
    }

    const scale = 1000;
    final fakeReceive = FakeReceiveProgress(duration: duration);
    try {
      return await request(
        (count, total) {
          onSendProgress?.call(count, total);
          if (!TransferProgress.isSendComplete(
            TransferProgress.portion(count, total),
          )) {
            return;
          }
          fakeReceive.start((value) {
            onReceiveProgress?.call((value * scale).round(), scale);
          });
        },
        null,
      );
    } finally {
      fakeReceive.stop();
    }
  }
}
