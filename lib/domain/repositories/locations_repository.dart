import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hedma/domain/models/responses/location_details_response.dart';
import 'package:hedma/domain/models/responses/locations_response.dart';

abstract class LocationsRepository {
  Future<LocationDetailsResponse> requestCurrentLocation();

  Future<LocationDetailsResponse> requestLocation(LatLng latlng);

  Future<LocationsResponse> requestLocations(String input);
}
