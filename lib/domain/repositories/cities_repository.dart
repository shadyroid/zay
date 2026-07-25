import 'package:zay/domain/models/responses/cities_response.dart';

abstract class CitiesRepository {
  Future<CitiesResponse> requestCities();
}
