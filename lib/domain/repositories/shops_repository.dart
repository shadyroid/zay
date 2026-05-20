import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/shop_response.dart';
import 'package:hedma/domain/models/responses/shops_response.dart';

abstract class ShopsRepository {
  Future<ShopsResponse> requestShops();

  Future<ShopResponse> requestShopDetails({required String shopId});

  Future<ProductsResponse> requestShopProducts({required String shopId});
}
