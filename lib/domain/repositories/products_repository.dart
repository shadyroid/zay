import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/categories_response.dart';
import 'package:hedma/domain/models/responses/product_response.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/sizes_response.dart';
import 'package:hedma/domain/models/responses/try_product_response.dart';
import 'package:hedma/domain/requests/product_details_request.dart';
import 'package:hedma/domain/requests/product_id_request.dart';
import 'package:hedma/domain/requests/products_request.dart';
import 'package:hedma/domain/requests/try_product_request.dart';

abstract class ProductsRepository {
  Future<CategoriesResponse> requestCategories();

  Future<SizesResponse> requestSizes();

  Future<ProductsResponse> requestProducts({
    ProductsRequest request = const ProductsRequest(),
  });

  Future<ProductResponse> requestProductDetails(ProductDetailsRequest request);

  Future<ProductsResponse> requestFavorites();

  Future<BaseResponse> requestFavorite(ProductIdRequest request);

  Future<BaseResponse> requestUnFavorite(ProductIdRequest request);

  Future<TryProductResponse> requestTryProduct(TryProductRequest request);
}
