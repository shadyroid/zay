import 'package:get/get.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/remote/dio_client.dart';
import 'package:zay/domain/requests/shop_details_request.dart';

class ShopsDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestShops() async {
    final response = await _dioClient.get(Constants.shopsPath);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> requestShopDetails(
    ShopDetailsRequest request,
  ) async {
    final response = await _dioClient.get(
      '${Constants.shopDetailsPath}/${request.shopId}',
    );
    return Map<String, dynamic>.from(response.data as Map);
  }
}
