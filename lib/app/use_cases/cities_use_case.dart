import 'package:get/get.dart';
import 'package:zay/data/repositories/cities_repository_impl.dart';
import 'package:zay/domain/models/responses/cities_response.dart';
import 'package:zay/domain/repositories/cities_repository.dart';

class CitiesUseCase {
  final CitiesRepository _citiesRepository = Get.put(CitiesRepositoryImpl());

  Future<CitiesResponse> requestCities() => _citiesRepository.requestCities();
}
