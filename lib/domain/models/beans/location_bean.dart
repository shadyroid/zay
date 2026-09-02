import 'package:zay/app/utils/parser.dart';

class LocationBean {
  const LocationBean({
    required this.address,
    required this.lat,
    required this.lng,
    this.addressComponents,
  });

  final String? address;
  final double? lat;
  final double? lng;
  final List<dynamic>? addressComponents;

  factory LocationBean.fromJson(Map<String, dynamic> json) {
    return LocationBean(
      address: json['address']?.toString(),
      lat: Parser.parseDouble(json['lat']),
      lng: Parser.parseDouble(json['lng']),
      addressComponents: json['address_components'] as List<dynamic>?,
    );
  }
}
