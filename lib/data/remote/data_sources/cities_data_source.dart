import 'package:get/get.dart';
import 'package:zay/app/utils/constants.dart';
import 'package:zay/data/remote/dio_client.dart';

class CitiesDataSource {
  final DioClient _dioClient = Get.put(DioClient());

  Future<Map<String, dynamic>> requestCities() async {
    final response = await _dioClient.get(Constants.citiesPath);
    return Map<String, dynamic>.from(response.data as Map);
  }
}
