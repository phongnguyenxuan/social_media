import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager instance =
      SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
    return instance;
  }

  SharedPreferencesManager._internal() {
    init();
  }

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _prefs;

    // Getters and setters for your preferences
  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  Future<bool> clear() {
    return _prefs.clear();
  }
}
