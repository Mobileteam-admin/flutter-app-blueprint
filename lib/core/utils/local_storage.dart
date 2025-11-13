import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static final SharedPrefManager _instance = SharedPrefManager._internal();
  factory SharedPrefManager() => _instance;
  SharedPrefManager._internal();

  SharedPreferences? _prefs;

  static const String keyLogin = "isLogin";
  static const String keyUserId = "userId";
  // static const String keyUsername = "username";
  static const String keyToken = "token";
  static const String keyOnboarding = "onboardingShown";
  // static const String keyPhoneNumber = "phoneNumber";
  static const String keyCartId = "cartId";
  static const String keyMealSlotOrderIds = "meal_slot_order_ids";
  // static const String keyAddress = "deliveryAddress";
  // static const String keyEmail = "emailId";
  static const String keyLunchAllowTime = "lunchAllowTime";
  static const String keyDinnerAllowTime = "dinnerAllowTime";
  static const String keyDeliveryFee = "deliveryFee";
  static const String keyVatPercentage = "vatPercentage";

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
