import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hedma/app/utils/google_maps_config.dart';
import 'package:hedma/domain/models/beans/location_address.dart';
import 'package:hedma/domain/models/beans/map_position.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationsDataSource {
  LocationsDataSource() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://maps.googleapis.com/maps/api',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }

  late final Dio _dio;
  String get _apiKey => GoogleMapsConfig.apiKey;

  Future<bool> requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isGranted) return true;
    status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  Future<MapPosition?> requestCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return MapPosition(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (_) {
      return null;
    }
  }

  Future<LocationAddress?> requestReverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/geocode/json',
        queryParameters: {
          'latlng': '$latitude,$longitude',
          'key': _apiKey,
        },
      );
      return _parseGeocodeResponse(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<List<PlacePrediction>> requestPlaceAutocomplete(String input) async {
    final query = input.trim();
    if (query.isEmpty) return [];

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/place/autocomplete/json',
        queryParameters: {
          'input': query,
          'key': _apiKey,
        },
      );
      final data = response.data;
      if (data == null || data['status'] != 'OK') return [];

      final predictions = data['predictions'] as List<dynamic>? ?? [];
      return predictions.map((item) {
        final map = item as Map<String, dynamic>;
        final structured =
            map['structured_formatting'] as Map<String, dynamic>?;
        return PlacePrediction(
          placeId: map['place_id'] as String? ?? '',
          description: map['description'] as String? ?? '',
          mainText: structured?['main_text'] as String?,
          secondaryText: structured?['secondary_text'] as String?,
        );
      }).where((p) => p.placeId.isNotEmpty).toList();
    } catch (_) {
      return [];
    }
  }

  Future<({MapPosition position, LocationAddress address})?> requestPlaceDetails(
    String placeId,
  ) async {
    if (placeId.isEmpty) return null;

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/place/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry,formatted_address,address_components',
          'key': _apiKey,
        },
      );
      final data = response.data;
      if (data == null || data['status'] != 'OK') return null;

      final result = data['result'] as Map<String, dynamic>?;
      if (result == null) return null;

      final geometry = result['geometry'] as Map<String, dynamic>?;
      final location = geometry?['location'] as Map<String, dynamic>?;
      final lat = (location?['lat'] as num?)?.toDouble();
      final lng = (location?['lng'] as num?)?.toDouble();
      if (lat == null || lng == null) return null;

      final address = _parseGeocodeResult(result);
      if (address == null) return null;

      return (
        position: MapPosition(latitude: lat, longitude: lng),
        address: address,
      );
    } catch (_) {
      return null;
    }
  }

  LocationAddress? _parseGeocodeResponse(Map<String, dynamic>? data) {
    if (data == null || data['status'] != 'OK') return null;
    final results = data['results'] as List<dynamic>?;
    if (results == null || results.isEmpty) return null;
    return _parseGeocodeResult(results.first as Map<String, dynamic>);
  }

  LocationAddress? _parseGeocodeResult(Map<String, dynamic> result) {
    final formatted = result['formatted_address'] as String? ?? '';
    if (formatted.isEmpty) return null;

    final components = result['address_components'] as List<dynamic>? ?? [];
    String? locality;
    String? adminArea;
    String? sublocality;

    for (final component in components) {
      final map = component as Map<String, dynamic>;
      final types = (map['types'] as List<dynamic>?)?.cast<String>() ?? [];
      final name = map['long_name'] as String? ?? '';
      if (types.contains('locality')) locality = name;
      if (types.contains('administrative_area_level_1')) adminArea = name;
      if (types.contains('sublocality') ||
          types.contains('sublocality_level_1')) {
        sublocality = name;
      }
    }

    final primaryParts = <String>[];
    if (sublocality != null && sublocality.isNotEmpty) {
      primaryParts.add(sublocality);
    }
    if (locality != null &&
        locality.isNotEmpty &&
        locality != sublocality) {
      primaryParts.add(locality);
    }
    if (adminArea != null && adminArea.isNotEmpty) {
      primaryParts.add(adminArea);
    }

    final primary = primaryParts.isNotEmpty
        ? primaryParts.join(', ')
        : formatted.split(',').take(2).join(',').trim();

    return LocationAddress(
      primary: primary,
      secondary: formatted,
      fullAddress: formatted,
    );
  }
}
