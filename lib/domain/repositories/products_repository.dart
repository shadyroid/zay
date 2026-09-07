import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/categories_response.dart';
import 'package:zay/domain/models/responses/product_response.dart';
import 'package:zay/domain/models/responses/products_response.dart';
import 'package:zay/domain/models/responses/sizes_response.dart';
import 'package:zay/domain/models/responses/try_on_response.dart';
import 'package:zay/domain/models/responses/types_response.dart';
import 'package:zay/domain/models/requests/product_details_request.dart';
import 'package:zay/domain/models/requests/product_id_request.dart';
import 'package:zay/domain/models/requests/products_request.dart';
import 'package:zay/domain/models/requests/try_on_details_request.dart';
import 'package:zay/domain/models/requests/try_on_request.dart';

abstract class ProductsRepository {
  Future<CategoriesResponse> requestCategories();

  Future<TypesResponse> requestTryOnCategories();

  Future<SizesResponse> requestSizes();

  Future<ProductsResponse> requestProducts(
    ProductsRequest request, {
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onReceiveProgress,
  });

  Future<ProductResponse> requestProductDetails(ProductDetailsRequest request);

  Future<ProductsResponse> requestFavorites();

  Future<BaseResponse> requestFavorite(ProductIdRequest request);

  Future<BaseResponse> requestUnFavorite(ProductIdRequest request);

  Future<TryOnResponse> requestTryOn(
    TryOnRequest request, {
    void Function(int count, int total)? onSendProgress,
    void Function(int count, int total)? onReceiveProgress,
  });

  Future<TryOnResponse> requestTryOnDetails(TryOnDetailsRequest request);
}
