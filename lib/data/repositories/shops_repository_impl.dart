import 'package:zay/data/remote/data_sources/shops_data_source.dart';
import 'package:zay/domain/models/responses/shop_response.dart';
import 'package:zay/domain/models/responses/shops_response.dart';
import 'package:zay/domain/repositories/shops_repository.dart';
import 'package:zay/domain/models/requests/shop_details_request.dart';

class ShopsRepositoryImpl implements ShopsRepository {
  final ShopsDataSource _shopsDataSource = ShopsDataSource();

  @override
  Future<ShopsResponse> requestShops() async {
    var json = await _shopsDataSource.requestShops();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['shops'],
    };
    return ShopsResponse.fromJson(json);
  }

  @override
  Future<ShopResponse> requestShopDetails(ShopDetailsRequest request) async {
    var json = await _shopsDataSource.requestShopDetails(request);
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['shop'],
    };
    return ShopResponse.fromJson(json);
  }
}
