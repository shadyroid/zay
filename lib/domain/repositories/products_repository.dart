import 'package:hedma/domain/models/responses/base_response.dart';
import 'package:hedma/domain/models/responses/categories_response.dart';
import 'package:hedma/domain/models/responses/product_response.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/sizes_response.dart';
import 'package:hedma/domain/models/responses/try_product_response.dart';

abstract class ProductsRepository {
  Future<CategoriesResponse> requestCategories();

  Future<SizesResponse> requestSizes();

  Future<ProductsResponse> requestProducts({String? categoryId});

  Future<ProductsResponse> requestFeaturedProducts();

  Future<ProductResponse> requestProductDetails({required String productId});

  Future<ProductsResponse> requestFavorites();

  Future<BaseResponse> requestFavorite({required String productId});

  Future<BaseResponse> requestUnFavorite({required String productId});

  Future<TryProductResponse> requestTryProduct({
    required String productId,
    required String imagePath,
  });
}
