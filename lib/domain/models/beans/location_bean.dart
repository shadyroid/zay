class LocationBean {
  const LocationBean({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String address;
  final double latitude;
  final double longitude;

  factory LocationBean.fromJson(Map<String, dynamic> json) {
    return LocationBean(
      address: json['address'],
      latitude: (json['latitude'] as num?)?.toDouble() ??
          (json['lat'] as num?)?.toDouble() ??
          0,
      longitude: (json['longitude'] as num?)?.toDouble() ??
          (json['lng'] as num?)?.toDouble() ??
          0,
    );
  }

  static List<LocationBean> listFromJson(List<dynamic>? json) {
    if (json == null) return [];
    return json
        .whereType<Map<String, dynamic>>()
        .map(LocationBean.fromJson)
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'lat': latitude,
        'lng': longitude,
      };
}
