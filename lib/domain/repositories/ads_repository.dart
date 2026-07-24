import 'package:zay/domain/models/responses/ads_response.dart';

abstract class AdsRepository {
  Future<AdsResponse> requestAds();
}
