import 'package:hedma/data/remote/data_sources/shops_data_source.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/shop_response.dart';
import 'package:hedma/domain/models/responses/shops_response.dart';
import 'package:hedma/domain/repositories/shops_repository.dart';

class ShopsRepositoryImpl implements ShopsRepository {
  final ShopsDataSource _shopsDataSource = ShopsDataSource();

  @override
  Future<ShopsResponse> requestShops() async {
    final json = await _shopsDataSource.requestShops();
    return ShopsResponse.fromJson(json);
  }

  @override
  Future<ShopResponse> requestShopDetails({required String shopId}) async {
    final json = await _shopsDataSource.requestShopDetails(shopId: shopId);
    return ShopResponse.fromJson(json);
  }

  @override
  Future<ProductsResponse> requestShopProducts({
    required String shopId,
  }) async {
    final json = await _shopsDataSource.requestShopProducts(shopId: shopId);
    return ProductsResponse.fromJson(json);
  }
}
