import 'package:zay/domain/models/beans/city_bean.dart';

abstract final class AddressCityMatcher {
  static const _componentTypes = <String>{
    'locality',
    'postal_town',
    'administrative_area_level_1',
    'administrative_area_level_2',
  };

  /// Finds the best matching city from [cities] using Google components
  /// and the formatted [address]. Prefers longer label matches.
  static CityBean? match({
    required String? address,
    required List<CityBean> cities,
    List<dynamic>? addressComponents,
  }) {
    if (cities.isEmpty) return null;

    return _matchLabels(_componentLabels(addressComponents), cities) ??
        _matchAddressText(address, cities);
  }

  static CityBean? _matchLabels(Iterable<String> labels, List<CityBean> cities) {
    CityBean? best;
    var bestScore = 0;

    for (final raw in labels) {
      final normalized = _normalize(raw);
      if (normalized.isEmpty) continue;

      for (final city in cities) {
        for (final cityLabel in city.matchLabels) {
          final cityNormalized = _normalize(cityLabel);
          if (cityNormalized.isEmpty) continue;
          if (normalized != cityNormalized &&
              !normalized.contains(cityNormalized)) {
            continue;
          }
          if (cityNormalized.length > bestScore) {
            best = city;
            bestScore = cityNormalized.length;
          }
        }
      }
    }

    return best;
  }

  static CityBean? _matchAddressText(String? address, List<CityBean> cities) {
    final text = _normalize(address);
    if (text.isEmpty) return null;

    CityBean? best;
    var bestScore = 0;

    for (final city in cities) {
      for (final label in city.matchLabels) {
        final normalized = _normalize(label);
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

  static Iterable<String> _componentLabels(List<dynamic>? addressComponents) {
    if (addressComponents == null || addressComponents.isEmpty) {
      return const <String>[];
    }

    final labels = <String>[];
    for (final raw in addressComponents) {
      if (raw is! Map) continue;
      final component = Map<String, dynamic>.from(raw);
      final types =
          (component['types'] as List?)?.map((e) => e.toString()).toSet() ??
              {};
      if (!types.any(_componentTypes.contains)) continue;

      final longName = component['long_name']?.toString().trim() ?? '';
      final shortName = component['short_name']?.toString().trim() ?? '';
      if (longName.isNotEmpty) labels.add(longName);
      if (shortName.isNotEmpty && shortName != longName) labels.add(shortName);
    }
    return labels;
  }

  static String _normalize(String? value) {
    return value
            ?.trim()
            .toLowerCase()
            .replaceAll('governorate', '')
            .replaceAll('محافظة', '')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim() ??
        '';
  }
}
