import 'package:get/get.dart';
import 'package:intl/intl.dart';

abstract final class AppDateFormat {
  static String get _locale => Get.locale?.languageCode ?? 'ar';

  static final List<DateFormat> _inputFormats = [
    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS"),
    DateFormat("yyyy-MM-dd'T'HH:mm:ss"),
    DateFormat('yyyy-MM-dd HH:mm:ss.SSS'),
    DateFormat('yyyy-MM-dd HH:mm:ss'),
    DateFormat('yyyy-MM-dd'),
  ];

  static DateTime? tryParse(String? raw) {
    if (raw == null) return null;
    final value = raw.trim();
    if (value.isEmpty) return null;

    for (final format in _inputFormats) {
      try {
        final isUtc = value.endsWith('Z') || value.contains('+');
        final parsed = format.parse(value, isUtc);
        return isUtc ? parsed.toLocal() : parsed;
      } catch (_) {}
    }

    try {
      return DateFormat().parseLoose(value).toLocal();
    } catch (_) {
      return null;
    }
  }

  /// e.g. Today, 2:30 PM · Yesterday, 9:05 AM · 15 Aug 2026, 2:30 PM
  static String friendly(String? raw) {
    final date = tryParse(raw);
    if (date == null) return raw?.trim() ?? '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);
    final time = DateFormat.jm(_locale).format(date);

    if (day == today) return '${'today'.tr}, $time';
    if (day == today.subtract(const Duration(days: 1))) {
      return '${'yesterday'.tr}, $time';
    }

    return DateFormat('d MMM yyyy, ', _locale).add_jm().format(date);
  }

  /// Day label for grouping, e.g. Today · Yesterday · 15 Aug 2026
  static String dayLabel(String? raw) {
    final date = tryParse(raw);
    if (date == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);

    if (day == today) return 'today'.tr;
    if (day == today.subtract(const Duration(days: 1))) return 'yesterday'.tr;
    return DateFormat.yMMMd(_locale).format(date);
  }
}
