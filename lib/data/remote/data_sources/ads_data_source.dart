import 'package:get/get.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/remote/dio_client.dart';

class AdsDataSource {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<Map<String, dynamic>> requestAds() async {
    final response = await _dioClient.get(Constants.adsPath);
    return Map<String, dynamic>.from(response.data as Map);
  }
}
