import 'package:zay/domain/models/beans/city_bean.dart';

class AddressCityArea {
  const AddressCityArea({this.city, this.area});

  final CityBean? city;
  final String? area;
}

abstract final class AddressCityAreaParser {
  /// Finds the best matching city from [cities] inside [address].
  /// Prefers longer label matches to avoid partial false positives.
  static CityBean? matchCity(String? address, List<CityBean> cities) {
    final text = address?.trim().toLowerCase() ?? '';
    if (text.isEmpty || cities.isEmpty) return null;

    CityBean? best;
    var bestScore = 0;

    for (final city in cities) {
      for (final label in city.matchLabels) {
        final normalized = label.trim().toLowerCase();
        if (normalized.isEmpty) continue;
        if (!text.contains(normalized)) continue;
        if (normalized.length > bestScore) {
          best = city;
          bestScore = normalized.length;
        }
      }
    }

    return best;
  }

  /// Extracts area text from Google [addressComponents], excluding city labels.
  static String? extractArea({
    required List<dynamic>? addressComponents,
    CityBean? matchedCity,
  }) {
    if (addressComponents == null || addressComponents.isEmpty) return null;

    const areaTypes = <String>{
      'sublocality',
      'sublocality_level_1',
      'sublocality_level_2',
      'neighborhood',
      'administrative_area_level_2',
      'administrative_area_level_3',
    };

    final cityLabels = matchedCity?.matchLabels
            .map((e) => e.trim().toLowerCase())
            .where((e) => e.isNotEmpty)
            .toSet() ??
        <String>{};

    for (final raw in addressComponents) {
      if (raw is! Map) continue;
      final component = Map<String, dynamic>.from(raw);
      final types = (component['types'] as List?)?.map((e) => e.toString()).toSet() ?? {};
      if (!types.any(areaTypes.contains)) continue;

      final longName = component['long_name']?.toString().trim() ?? '';
      if (longName.isEmpty) continue;
      if (cityLabels.contains(longName.toLowerCase())) continue;
      return longName;
    }

    return null;
  }

  /// Fallback: use the first comma-separated segment that is not the city.
  static String? extractAreaFromAddress(String? address, CityBean? city) {
    final text = address?.trim() ?? '';
    if (text.isEmpty) return null;

    final parts = text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (parts.isEmpty) return null;

    final cityLabels = city?.matchLabels
            .map((e) => e.trim().toLowerCase())
            .where((e) => e.isNotEmpty)
            .toSet() ??
        <String>{};

    for (final part in parts) {
      final lower = part.toLowerCase();
      if (cityLabels.any((label) => lower == label || lower.contains(label))) {
        continue;
      }
      // Skip country-like trailing parts
      if (lower == 'egypt' || lower == 'مصر') continue;
      return part;
    }

    return null;
  }

  static AddressCityArea resolve({
    required String? address,
    required List<CityBean> cities,
    List<dynamic>? addressComponents,
  }) {
    final city = matchCity(address, cities);
    final area = extractArea(
          addressComponents: addressComponents,
          matchedCity: city,
        ) ??
        extractAreaFromAddress(address, city);

    return AddressCityArea(city: city, area: area);
  }
}
