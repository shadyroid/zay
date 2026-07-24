import 'package:get/get.dart';
import 'package:zay/data/repositories/ads_repository_impl.dart';
import 'package:zay/domain/models/responses/ads_response.dart';
import 'package:zay/domain/repositories/ads_repository.dart';

class AdsUseCase {
  final AdsRepository _adsRepository = Get.put(AdsRepositoryImpl());

  Future<AdsResponse> requestAds() => _adsRepository.requestAds();
}
