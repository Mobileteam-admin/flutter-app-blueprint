import 'package:get/get.dart';

import 'local_storage.dart';

class LocalDataService extends GetxService {
  final _prefs = SharedPrefManager();

  static const String keyUsername = "username";
  static const String keyPhoneNumber = "phoneNumber";
  static const String keyAddress = "address";
  static const String keyEmail = "email";

  // Reactive fields
  RxString username = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString address = ''.obs;
  RxString email = ''.obs;
  // RxString cartId = ''.obs;
  // RxMap<String, String> mealSlotOrderIds = <String, String>{}.obs;

  // Load all values at startup
  Future<LocalDataService> init() async {
  // Future<void> initData() async {
    username.value = _prefs.getString(keyUsername) ?? '';
    phoneNumber.value = _prefs.getString(keyPhoneNumber) ?? '';
    address.value = _prefs.getString(keyAddress) ?? '';
    email.value = _prefs.getString(keyEmail) ?? '';

    // cartId.value = _prefs.getString(SharedPrefManager.keyCartId) ?? '';
    // final mealSlotStr = _prefs.getString(SharedPrefManager.keyMealSlotOrderIds);
    // if (mealSlotStr != null && mealSlotStr.isNotEmpty) {
    //   final Map<String, dynamic> decoded = jsonDecode(mealSlotStr);
    //   mealSlotOrderIds.value = decoded.map((k, v) => MapEntry(k, v.toString()));
    // }
    return this;
  }

  // Setter methods (update prefs + UI)
  Future<void> setUsername(String value) async {
    username.value = value;
    await _prefs.setString(keyUsername, value);
  }

  Future<void> setPhoneNumber(String value) async {
    phoneNumber.value = value;
    await _prefs.setString(keyPhoneNumber, value);
  }


  Future<void> setAddress(String value) async {
    address.value = value;
    await _prefs.setString(keyAddress, value);
  }

  Future<void> setEmail(String value) async {
    email.value = value;
    await _prefs.setString(keyEmail, value);
  }

  // Future<void> setCartId(String value) async {
  //   cartId.value = value;
  //   await _prefs.setString(SharedPrefManager.keyCartId, value);
  // }


  // Future<void> setMealSlotOrderIds(Map<String, String> value) async {
  //   mealSlotOrderIds.value = value;
  //   await _prefs.setString(
  //     SharedPrefManager.keyMealSlotOrderIds,
  //     jsonEncode(value),
  //   );
  // }

  // Clear everything (logout)
  Future<void> clearAllData() async {
    username.value = '';
    phoneNumber.value = '';
    address.value = '';
    email.value = '';
    // cartId.value = '';
    // mealSlotOrderIds.clear();
    await _prefs.clearAll();
  }
}
