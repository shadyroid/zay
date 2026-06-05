class LocationBean {
  const LocationBean({
    required this.address,
    required this.lat,
    required this.lng,
  });

  final String? address;
  final double? lat;
  final double? lng;

  factory LocationBean.fromJson(Map<String, dynamic> json) {
    return LocationBean(
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
