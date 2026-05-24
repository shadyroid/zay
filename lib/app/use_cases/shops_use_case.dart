import 'package:get/get.dart';
import 'package:hedma/data/repositories/shops_repository_impl.dart';
import 'package:hedma/domain/models/responses/shop_response.dart';
import 'package:hedma/domain/models/responses/shops_response.dart';
import 'package:hedma/domain/repositories/shops_repository.dart';
import 'package:hedma/domain/requests/shop_details_request.dart';

class ShopsUseCase {
  final ShopsRepository _shopsRepository = Get.put(ShopsRepositoryImpl());

  Future<ShopsResponse> requestShops() => _shopsRepository.requestShops();

  Future<ShopResponse> requestShopDetails(ShopDetailsRequest request) =>
      _shopsRepository.requestShopDetails(request);
}
