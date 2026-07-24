import 'package:zay/domain/models/responses/shop_response.dart';
import 'package:zay/domain/models/responses/shops_response.dart';
import 'package:zay/domain/models/requests/shop_details_request.dart';

abstract class ShopsRepository {
  Future<ShopsResponse> requestShops();

  Future<ShopResponse> requestShopDetails(ShopDetailsRequest request);
}
