import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hedma/data/remote/data_sources/locations_data_source.dart';
import 'package:hedma/domain/models/beans/location_bean.dart';
import 'package:hedma/domain/models/responses/location_details_response.dart';
import 'package:hedma/domain/models/responses/locations_response.dart';
import 'package:hedma/domain/repositories/locations_repository.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsDataSource _dataSource = LocationsDataSource();

  static const _autocompleteLimit = 5;

  @override
  Future<LocationDetailsResponse> requestCurrentLocation() async {
    final granted = await _requestLocationPermission();
    if (!granted) {
      return const LocationDetailsResponse(
        statusCode: 400,
        message: 'locationPermissionDenied',
      );
    }

    final positionJson = await _dataSource.requestCurrentPosition();
    if ((positionJson['statusCode'] as int? ?? -2) != 200) {
      return LocationDetailsResponse.fromJson(positionJson);
    }

    final positionData = positionJson['data'] as Map<String, dynamic>?;
    final lat = (positionData?['latitude'] as num?)?.toDouble();
    final lng = (positionData?['longitude'] as num?)?.toDouble();
    if (lat == null || lng == null) {
      return const LocationDetailsResponse(
        statusCode: -2,
        message: 'locationUnavailable',
      );
    }

    return requestLocation(LatLng(lat, lng));
  }

  @override
  Future<LocationDetailsResponse> requestLocation(LatLng latlng) async {
    final json = await _dataSource.requestReverseGeocode(
      latitude: latlng.latitude,
      longitude: latlng.longitude,
    );

    if ((json['statusCode'] as int? ?? -2) != 200) {
      return LocationDetailsResponse.fromJson(json);
    }

    final google = json['data'] as Map<String, dynamic>?;
    final location = _parseGeocodeResponse(google);
    if (location == null) {
      return const LocationDetailsResponse(
        statusCode: -2,
        message: 'locationUnavailable',
      );
    }

    return LocationDetailsResponse(statusCode: 200, data: location);
  }

  @override
  Future<LocationsResponse> requestLocations(String input) async {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return const LocationsResponse(statusCode: 200, data: []);
    }

    if (_looksLikePlaceId(trimmed)) {
      final location = await _locationFromPlaceId(trimmed);
      if (location == null) {
        return const LocationsResponse(
          statusCode: -2,
          message: 'locationUnavailable',
        );
      }
      return LocationsResponse(statusCode: 200, data: [location]);
    }

    final json = await _dataSource.requestPlaceAutocomplete(trimmed);
    if ((json['statusCode'] as int? ?? -2) != 200) {
      return LocationsResponse.fromJson(json);
    }

    final google = json['data'] as Map<String, dynamic>?;
    return _parseAutocompleteResponse(google);
  }

  Future<LocationsResponse> _parseAutocompleteResponse(
    Map<String, dynamic>? google,
  ) async {
    if (google == null || google['status'] != 'OK') {
      return const LocationsResponse(statusCode: 200, data: []);
    }

    final predictions = google['predictions'] as List<dynamic>? ?? [];
    final placeIds = <String>[];

    for (final item in predictions.take(_autocompleteLimit)) {
      if (item is! Map<String, dynamic>) continue;
      final placeId = item['place_id'] as String? ?? '';
      if (placeId.isNotEmpty) placeIds.add(placeId);
    }

    final locations = await Future.wait(placeIds.map(_locationFromPlaceId));

    return LocationsResponse(
      statusCode: 200,
      data: locations.whereType<LocationBean>().toList(),
    );
  }

  Future<LocationBean?> _locationFromPlaceId(String placeId) async {
    final json = await _dataSource.requestPlaceDetails(placeId);
    if ((json['statusCode'] as int? ?? -2) != 200) return null;

    final google = json['data'] as Map<String, dynamic>?;
    if (google == null || google['status'] != 'OK') return null;

    final result = google['result'] as Map<String, dynamic>?;
    if (result == null) return null;

    final geometry = result['geometry'] as Map<String, dynamic>?;
    final coordinates = geometry?['location'] as Map<String, dynamic>?;
    final lat = (coordinates?['lat'] as num?)?.toDouble();
    final lng = (coordinates?['lng'] as num?)?.toDouble();
    final address = result['formatted_address'] as String? ?? '';

    if (lat == null || lng == null || address.isEmpty) return null;

    return LocationBean(address: address, lat: lat, lng: lng);
  }

  LocationBean? _parseGeocodeResponse(Map<String, dynamic>? google) {
    if (google == null || google['status'] != 'OK') return null;

    final results = google['results'] as List<dynamic>?;
    if (results == null || results.isEmpty) return null;

    final result = results.first;
    if (result is! Map<String, dynamic>) return null;

    final address = result['formatted_address'] as String? ?? '';
    final geometry = result['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;
    final lat = (location?['lat'] as num?)?.toDouble();
    final lng = (location?['lng'] as num?)?.toDouble();

    if (address.isEmpty || lat == null || lng == null) return null;

    return LocationBean(address: address, lat: lat, lng: lng);
  }

  Future<bool> _requestLocationPermission() async {
    var locationPermission = await Geolocator.requestPermission();
    return locationPermission == LocationPermission.whileInUse;
  }

  bool _looksLikePlaceId(String value) =>
      !value.contains(' ') && value.length > 12;
}
