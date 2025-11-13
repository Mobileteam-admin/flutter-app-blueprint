import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final RxBool isOnline = true.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _checkInitialStatus();

    _connectivity.onConnectivityChanged.listen((results) {
      final result = results.firstWhere(
            (r) => r != ConnectivityResult.none,
        orElse: () => ConnectivityResult.none,
      );
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    final wasOnline = isOnline.value;
    isOnline.value = result != ConnectivityResult.none;

    if (wasOnline != isOnline.value) {
      if (isOnline.value) {
        Get.closeAllSnackbars();
        Get.snackbar(
          "Back Online ✅",
          "Your internet connection is restored.",
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.onSecondary,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "You're Offline ❌",
          "Please check your internet connection.",
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
          duration: const Duration(days: 1),
        );
      }
    }
  }

  Future<void> _checkInitialStatus() async {
    final results = await _connectivity.checkConnectivity();

    final result = results.firstWhere(
          (r) => r != ConnectivityResult.none,
      orElse: () => ConnectivityResult.none,
    );

    _updateConnectionStatus(result);
  }
}
