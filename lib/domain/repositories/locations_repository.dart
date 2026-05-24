import 'package:hedma/domain/models/beans/location_address.dart';
import 'package:hedma/domain/models/beans/map_position.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';
import 'package:hedma/domain/requests/place_autocomplete_request.dart';
import 'package:hedma/domain/requests/place_details_request.dart';
import 'package:hedma/domain/requests/reverse_geocode_request.dart';

abstract class LocationsRepository {
  Future<MapPosition?> requestCurrentPosition();

  Future<bool> requestLocationPermission();

  Future<LocationAddress?> requestReverseGeocode(ReverseGeocodeRequest request);

  Future<List<PlacePrediction>> requestPlaceAutocomplete(
    PlaceAutocompleteRequest request,
  );

  Future<({MapPosition position, LocationAddress address})?> requestPlaceDetails(
    PlaceDetailsRequest request,
  );
}
