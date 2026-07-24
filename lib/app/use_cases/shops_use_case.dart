import 'package:get/get.dart';
import 'package:zay/data/repositories/shops_repository_impl.dart';
import 'package:zay/domain/models/responses/shop_response.dart';
import 'package:zay/domain/models/responses/shops_response.dart';
import 'package:zay/domain/repositories/shops_repository.dart';
import 'package:zay/domain/models/requests/shop_details_request.dart';

class ShopsUseCase {
  final ShopsRepository _shopsRepository = Get.put(ShopsRepositoryImpl());

  Future<ShopsResponse> requestShops() => _shopsRepository.requestShops();

  Future<ShopResponse> requestShopDetails(ShopDetailsRequest request) =>
      _shopsRepository.requestShopDetails(request);
}
