import 'package:get/get.dart';

import '../../../core/utils/local_storage.dart';

class HomeViewModel extends GetxController {
  final RxString loggedInEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get email from arguments passed during navigation
    final emailArg = Get.arguments?['email'];
    if (emailArg != null) {
      loggedInEmail.value = emailArg;
    } else {
      loggedInEmail.value = 'admin@example.com'; // fallback dummy
    }
  }

  /// Simple dummy logout
  void logout() {
    SharedPrefManager().setBool(SharedPrefManager.keyLogin, false);
    SharedPrefManager().clearAll();
    Get.offAllNamed('/login');
  }

  /// Greeting message based on time of day
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning!";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
    }
  }
}
