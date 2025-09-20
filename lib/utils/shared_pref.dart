import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _instance = SharedPref._internal();
  static SharedPreferences? _prefs;

  factory SharedPref() {
    return _instance;
  }

  SharedPref._internal();

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> setData(String key, String value) async {
    return await _prefs!.setString(key, value);
  }

  String? getValue(String key) {
    return _prefs!.getString(key);
  }

  Future<bool> clearData() async {
    return await _prefs!.clear();
  }

  Future<bool> removeData(String key) async {
    return await _prefs!.remove(key);
  }
}
