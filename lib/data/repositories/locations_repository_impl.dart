import 'package:hedma/data/remote/data_sources/locations_data_source.dart';
import 'package:hedma/domain/models/beans/location_address.dart';
import 'package:hedma/domain/models/beans/map_position.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';
import 'package:hedma/domain/repositories/locations_repository.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsDataSource _dataSource = LocationsDataSource();

  @override
  Future<bool> requestLocationPermission() =>
      _dataSource.requestLocationPermission();

  @override
  Future<MapPosition?> requestCurrentPosition() =>
      _dataSource.requestCurrentPosition();

  @override
  Future<LocationAddress?> requestReverseGeocode({
    required double latitude,
    required double longitude,
  }) =>
      _dataSource.requestReverseGeocode(
        latitude: latitude,
        longitude: longitude,
      );

  @override
  Future<List<PlacePrediction>> requestPlaceAutocomplete(String input) =>
      _dataSource.requestPlaceAutocomplete(input);

  @override
  Future<({MapPosition position, LocationAddress address})?>
      requestPlaceDetails(String placeId) =>
          _dataSource.requestPlaceDetails(placeId);
}
