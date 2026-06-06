class Parser {
  static int? parseInt(dynamic json) {
    if (json == null) return null;
    if (json is String) return int.parse(json);
    if (json is double) return json.toInt();

    return json;
  }

  static String? parseString(dynamic json) {
    if (json == null) return null;
    if (json is int) return json.toString();
    if (json is double) return json.toString();

    return json;
  }

  static double? parseDouble(dynamic json) {
    if (json == null) return null;
    if (json is String) return double.parse(json.replaceAll(',', ''));
    if (json is int) return json.toDouble();

    return json;
  }

  static bool parseBoolean(dynamic json) {
    if (json == null) return false;
    if (json is String) {
      if (json == 'false' || json == '0') {
        return false;
      } else if (json == 'true') {
        return true;
      } else if (json == '0') {
        return false;
      } else if (json == '1') {
        return true;
      } else {
        return false;
      }
    }
    if (json is int) {
      if (json == 0) {
        return false;
      } else if (json == 1) {
        return true;
      } else {
        return false;
      }
    }

    return json;
  }
}
