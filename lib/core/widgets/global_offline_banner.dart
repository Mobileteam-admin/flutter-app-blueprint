import 'package:flutter_base_project/core/utils/connectivity_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalOfflineBanner extends StatelessWidget {
  final ConnectivityController controller = Get.find();

   GlobalOfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isOnline.value
          ? const SizedBox.shrink()
          : Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        color: Colors.red,
        child: const Text(
          "🔌 You're Offline",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
