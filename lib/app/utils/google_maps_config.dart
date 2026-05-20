import 'dart:io';

abstract final class GoogleMapsConfig {
  static const String _androidApiKey =
      'AIzaSyDoOZM9EdzZheO55asgGDt3Fa3N40LZY68';
  static const String _iosApiKey =
      'AIzaSyCctiejAaCmiyTMA3SoDDIM9OrW67399zE';

  static String get apiKey => Platform.isIOS ? _iosApiKey : _androidApiKey;
}
