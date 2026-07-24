import 'package:zay/data/remote/data_sources/ads_data_source.dart';
import 'package:zay/domain/models/responses/ads_response.dart';
import 'package:zay/domain/repositories/ads_repository.dart';

class AdsRepositoryImpl implements AdsRepository {
  final AdsDataSource _adsDataSource = AdsDataSource();

  @override
  Future<AdsResponse> requestAds() async {
    var json = await _adsDataSource.requestAds();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['ads'],
    };
    return AdsResponse.fromJson(json);
  }
}
