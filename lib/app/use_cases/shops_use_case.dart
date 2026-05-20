import 'package:get/get.dart';
import 'package:hedma/data/repositories/shops_repository_impl.dart';
import 'package:hedma/domain/models/responses/products_response.dart';
import 'package:hedma/domain/models/responses/shop_response.dart';
import 'package:hedma/domain/models/responses/shops_response.dart';
import 'package:hedma/domain/repositories/shops_repository.dart';

class ShopsUseCase {
  final ShopsRepository _shopsRepository = Get.put(ShopsRepositoryImpl());

  Future<ShopsResponse> requestShops() => _shopsRepository.requestShops();

  Future<ShopResponse> requestShopDetails({required String shopId}) =>
      _shopsRepository.requestShopDetails(shopId: shopId);

  Future<ProductsResponse> requestShopProducts({required String shopId}) =>
      _shopsRepository.requestShopProducts(shopId: shopId);
}
