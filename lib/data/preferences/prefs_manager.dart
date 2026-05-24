import 'package:hedma/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? get token => _prefs?.getString(Constants.tokenKey);

  static bool get isLoggedIn {
    final value = token;
    return value != null && value.isNotEmpty;
  }

  static Future<void> setToken(String value) async {
    await _prefs?.setString(Constants.tokenKey, value);
  }

  static String? get locale => _prefs?.getString(Constants.localeKey);

  static Future<void> setLocale(String value) async {
    await _prefs?.setString(Constants.localeKey, value);
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
