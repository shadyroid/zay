import 'package:hedma/domain/models/beans/location_address.dart';
import 'package:hedma/domain/models/beans/map_position.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';

abstract class LocationsRepository {
  Future<MapPosition?> requestCurrentPosition();

  Future<bool> requestLocationPermission();

  Future<LocationAddress?> requestReverseGeocode({
    required double latitude,
    required double longitude,
  });

  Future<List<PlacePrediction>> requestPlaceAutocomplete(String input);

  Future<({MapPosition position, LocationAddress address})?> requestPlaceDetails(
    String placeId,
  );
}
