import 'package:get/get.dart';
import 'package:hedma/data/repositories/locations_repository_impl.dart';
import 'package:hedma/domain/models/beans/location_address.dart';
import 'package:hedma/domain/models/beans/map_position.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';
import 'package:hedma/domain/repositories/locations_repository.dart';

class LocationsUseCase {
  final LocationsRepository _repository = Get.put(LocationsRepositoryImpl());

  Future<bool> requestLocationPermission() =>
      _repository.requestLocationPermission();

  Future<MapPosition?> requestCurrentPosition() =>
      _repository.requestCurrentPosition();

  Future<LocationAddress?> requestReverseGeocode({
    required double latitude,
    required double longitude,
  }) =>
      _repository.requestReverseGeocode(
        latitude: latitude,
        longitude: longitude,
      );

  Future<List<PlacePrediction>> requestPlaceAutocomplete(String input) =>
      _repository.requestPlaceAutocomplete(input);

  Future<({MapPosition position, LocationAddress address})?>
      requestPlaceDetails(String placeId) =>
          _repository.requestPlaceDetails(placeId);
}
