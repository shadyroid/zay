import 'package:zay/domain/models/responses/base_response.dart';
import 'package:zay/domain/models/responses/categories_response.dart';
import 'package:zay/domain/models/responses/product_response.dart';
import 'package:zay/domain/models/responses/products_response.dart';
import 'package:zay/domain/models/responses/sizes_response.dart';
import 'package:zay/domain/models/responses/try_on_response.dart';
import 'package:zay/domain/requests/product_details_request.dart';
import 'package:zay/domain/requests/product_id_request.dart';
import 'package:zay/domain/requests/products_request.dart';
import 'package:zay/domain/requests/try_on_request.dart';

abstract class ProductsRepository {
  Future<CategoriesResponse> requestCategories();

  Future<SizesResponse> requestSizes();

  Future<ProductsResponse> requestProducts(ProductsRequest request);

  Future<ProductResponse> requestProductDetails(ProductDetailsRequest request);

  Future<ProductsResponse> requestFavorites();

  Future<BaseResponse> requestFavorite(ProductIdRequest request);

  Future<BaseResponse> requestUnFavorite(ProductIdRequest request);

  Future<TryOnResponse> requestTryOn(TryOnRequest request);
}
