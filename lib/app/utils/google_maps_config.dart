import 'dart:io';

abstract final class GoogleMapsConfig {
  static const String _androidApiKey =
      'AIzaSyCl17JMFp4Yi4MwSZHs-AflhjDs6QoifQI';
  static const String _iosApiKey =
      'AIzaSyDh8DrMA40-QDfXpm6EkM_4SxA-Jt4a94w';

  static String get apiKey => Platform.isIOS ? _iosApiKey : _androidApiKey;
}
