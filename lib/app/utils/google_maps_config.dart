import 'dart:io';

abstract final class GoogleMapsConfig {
  static const String _androidApiKey =
      'AIzaSyD63-K8d3YvJ1E9h4WnNRF0Rg_3zjdjzx0';
  static const String _iosApiKey =
      'AIzaSyCoGOX-qA72_ljwzyUMdR1_vTrchc86VN4';

  static String get apiKey => Platform.isIOS ? _iosApiKey : _androidApiKey;
}
