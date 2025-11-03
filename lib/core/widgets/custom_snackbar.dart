import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    IconData? icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      margin: const EdgeInsets.all(12),
      duration: duration,
      icon: icon != null ? Icon(icon, color: textColor) : null,
    );
  }

  static void success(String message) {
    show(
      title: "Success",
      message: message,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 1),
      icon: Icons.check_circle,
    );
  }

  static void error(String message) {
    show(
      title: "Error",
      message: message,
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 3),
      icon: Icons.error,
    );
  }

  static void warning(String message) {
    show(
      title: "Warning",
      message: message,
      backgroundColor: Colors.orange.shade700,
      duration: const Duration(seconds: 2),
      icon: Icons.warning,
    );
  }

  static void info(String message) {
    show(
      title: "Info",
      message: message,
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 2),
      icon: Icons.info_outline,
    );
  }
}
