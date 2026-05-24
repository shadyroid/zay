import 'package:hedma/data/remote/data_sources/locations_data_source.dart';
import 'package:hedma/domain/models/beans/location_address.dart';
import 'package:hedma/domain/models/beans/map_position.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';
import 'package:hedma/domain/repositories/locations_repository.dart';
import 'package:hedma/domain/requests/place_autocomplete_request.dart';
import 'package:hedma/domain/requests/place_details_request.dart';
import 'package:hedma/domain/requests/reverse_geocode_request.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsDataSource _dataSource = LocationsDataSource();

  @override
  Future<bool> requestLocationPermission() =>
      _dataSource.requestLocationPermission();

  @override
  Future<MapPosition?> requestCurrentPosition() =>
      _dataSource.requestCurrentPosition();

  @override
  Future<LocationAddress?> requestReverseGeocode(
    ReverseGeocodeRequest request,
  ) =>
      _dataSource.requestReverseGeocode(request);

  @override
  Future<List<PlacePrediction>> requestPlaceAutocomplete(
    PlaceAutocompleteRequest request,
  ) =>
      _dataSource.requestPlaceAutocomplete(request);

  @override
  Future<({MapPosition position, LocationAddress address})?>
      requestPlaceDetails(PlaceDetailsRequest request) =>
          _dataSource.requestPlaceDetails(request);
}
