import 'package:get/get.dart';
import 'package:hedma/data/repositories/locations_repository_impl.dart';
import 'package:hedma/domain/models/beans/location_address.dart';
import 'package:hedma/domain/models/beans/map_position.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';
import 'package:hedma/domain/repositories/locations_repository.dart';
import 'package:hedma/domain/requests/place_autocomplete_request.dart';
import 'package:hedma/domain/requests/place_details_request.dart';
import 'package:hedma/domain/requests/reverse_geocode_request.dart';

class LocationsUseCase {
  final LocationsRepository _repository = Get.put(LocationsRepositoryImpl());

  Future<bool> requestLocationPermission() =>
      _repository.requestLocationPermission();

  Future<MapPosition?> requestCurrentPosition() =>
      _repository.requestCurrentPosition();

  Future<LocationAddress?> requestReverseGeocode(
    ReverseGeocodeRequest request,
  ) =>
      _repository.requestReverseGeocode(request);

  Future<List<PlacePrediction>> requestPlaceAutocomplete(
    PlaceAutocompleteRequest request,
  ) =>
      _repository.requestPlaceAutocomplete(request);

  Future<({MapPosition position, LocationAddress address})?>
      requestPlaceDetails(PlaceDetailsRequest request) =>
          _repository.requestPlaceDetails(request);
}
