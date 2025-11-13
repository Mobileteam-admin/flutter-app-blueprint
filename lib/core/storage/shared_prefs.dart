import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static final SharedPrefManager _instance = SharedPrefManager._internal();
  factory SharedPrefManager() => _instance;
  SharedPrefManager._internal();

  SharedPreferences? _prefs;

  static const String keyLogin = "isLogin";
  static const String keyToken = "accessToken";
  static const String keyRefresh = "refreshToken";
  static const String keyUserName = "username";

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }
  bool? getBool(String key) => _prefs?.getBool(key);

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }
  String? getString(String key) => _prefs?.getString(key);

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
