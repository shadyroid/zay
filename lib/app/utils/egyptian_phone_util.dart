import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Validates Egyptian mobile numbers (Vodafone 010, Etisalat 011, Orange 012, WE 015).
abstract final class EgyptianPhoneUtil {
  /// Local format: 01 + operator (0/1/2/5) + 8 digits.
  static const int maxLength = 11;

  static final RegExp _localPattern = RegExp(r'^01[0125]\d{8}$');

  static final List<TextInputFormatter> inputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(maxLength),
  ];

  /// Normalizes input to local 11-digit form: 01XXXXXXXXX.
  static String? normalize(String? value) {
    if (value == null) return null;

    var digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;

    if (digits.startsWith('0020')) {
      digits = digits.substring(4);
    } else if (digits.startsWith('20')) {
      digits = digits.substring(2);
    }

    if (digits.length == 10 && digits.startsWith('1')) {
      digits = '0$digits';
    }

    return digits;
  }

  static bool isValid(String? value) {
    final normalized = normalize(value);
    if (normalized == null) return false;
    return _localPattern.hasMatch(normalized);
  }

  /// [required]: empty is an error. Otherwise empty is allowed; non-empty must be valid.
  static String? validate(String? value, {bool required = false}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return required ? 'mobileRequired'.tr : null;
    }
    if (!isValid(trimmed)) {
      return 'phoneInvalid'.tr;
    }
    return null;
  }
}
