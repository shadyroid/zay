import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hedma/data/repositories/locations_repository_impl.dart';
import 'package:hedma/domain/models/responses/location_details_response.dart';
import 'package:hedma/domain/models/responses/locations_response.dart';
import 'package:hedma/domain/repositories/locations_repository.dart';

class LocationsUseCase {
  final LocationsRepository _repository = Get.put(LocationsRepositoryImpl());

  Future<LocationDetailsResponse> requestCurrentLocation() =>
      _repository.requestCurrentLocation();

  Future<LocationDetailsResponse> requestLocation(LatLng latlng) =>
      _repository.requestLocation(latlng);

  Future<LocationsResponse> requestLocations(String input) =>
      _repository.requestLocations(input);
}
