import 'package:zay/data/remote/data_sources/cities_data_source.dart';
import 'package:zay/domain/models/responses/cities_response.dart';
import 'package:zay/domain/repositories/cities_repository.dart';
import 'package:get/get.dart';

class CitiesRepositoryImpl implements CitiesRepository {
 final CitiesDataSource _citiesDataSource = Get.put(CitiesDataSource());

  @override
  Future<CitiesResponse> requestCities() async {
    var json = await _citiesDataSource.requestCities();
    json = {
      "statusCode": json['statusCode'],
      "message": json['message'],
      "data": json['cities'],
    };
    return CitiesResponse.fromJson(json);
  }
}
