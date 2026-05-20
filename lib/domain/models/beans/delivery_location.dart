class DeliveryLocation {
  const DeliveryLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String address;
  final double latitude;
  final double longitude;

  factory DeliveryLocation.fromMap(Map<String, dynamic> map) {
    return DeliveryLocation(
      address: map['address'] as String? ?? '',
      latitude: (map['lat'] as num?)?.toDouble() ??
          (map['latitude'] as num?)?.toDouble() ??
          0,
      longitude: (map['lng'] as num?)?.toDouble() ??
          (map['longitude'] as num?)?.toDouble() ??
          0,
    );
  }
}
