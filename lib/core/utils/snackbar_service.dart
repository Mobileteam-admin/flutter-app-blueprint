import 'package:flutter/material.dart';
import '../../main.dart';

class SnackbarService {
  static void showMessage(String text) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(text)));
  }

  static void showError(String text) {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(text), backgroundColor: Colors.red));
  }
}
