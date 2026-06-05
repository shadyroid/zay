import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hedma/app/utils/google_maps_config.dart';

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

  Future<Map<String, dynamic>> requestCurrentPosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return _failure('locationUnavailable');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      return _success(
        data: {
          'lat': position.latitude,
          'lng': position.longitude,
        },
      );
    } catch (_) {
      return _failure('locationUnavailable');
    }
  }

  Future<Map<String, dynamic>> requestReverseGeocode({
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
      return _success(data: response.data ?? {});
    } catch (_) {
      return _failure();
    }
  }

  Future<Map<String, dynamic>> requestPlaceAutocomplete(String input) async {
    final query = input.trim();
    if (query.isEmpty) {
      return _success(data: {'predictions': <dynamic>[]});
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/place/autocomplete/json',
        queryParameters: {
          'input': query,
          'key': _apiKey,
        },
      );
      return _success(data: response.data ?? {});
    } catch (_) {
      return _failure();
    }
  }

  Future<Map<String, dynamic>> requestPlaceDetails(String placeId) async {
    if (placeId.isEmpty) {
      return _failure();
    }

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/place/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry,formatted_address,address_components',
          'key': _apiKey,
        },
      );
      return _success(data: response.data ?? {});
    } catch (_) {
      return _failure();
    }
  }

  Map<String, dynamic> _success({dynamic data}) => {
        'statusCode': 200,
        'data': data,
      };

  Map<String, dynamic> _failure([String? message]) => {
        'statusCode': -2,
        'message': message,
        'data': null,
      };
}
