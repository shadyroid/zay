class LocationBean {
  const LocationBean({
    required this.address,
    required this.lat,
    required this.lng,
    this.city,
    this.area,
    this.addressComponents,
  });

  final String? address;
  final double? lat;
  final double? lng;
  final String? city;
  final String? area;
  final List<dynamic>? addressComponents;

  factory LocationBean.fromJson(Map<String, dynamic> json) {
    return LocationBean(
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
      city: json['city'],
      area: json['area'],
      addressComponents: json['address_components'] as List<dynamic>?,
    );
  }
}
