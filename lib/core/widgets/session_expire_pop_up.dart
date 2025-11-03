import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_sizes.dart';
import '../utils/app_size.dart';
import '../utils/widget_decoration.dart';

// Use the same variable name consistently
bool _isLoggingOut = false;

void handleUnauthorized() async {
  // Already logging out → skip further dialogs
  if (_isLoggingOut) return;
  _isLoggingOut = true;

  // If dialog already open, don't open again
  if (Get.isDialogOpen ?? false) return;

  Get.dialog(
    AlertDialog(
      title: const Text("Session Expired",
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      titleTextStyle: TextStyle(
        fontSize: AppSizer.fontSize(Get.context!, AppSizes.fontSize15, AppSizes.fontSize20),
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      content: const Text("Your session has expired. Please log in again."),
      actions: [
        // TextButton(
        //   onPressed: () async {
        //     // Close the dialog
        //     Get.back();
        //
        //     // Ensure ProfileViewModel is available
        //     Get.lazyPut(() => ProfileViewModel());
        //
        //     // Log out the user
        //     await Get.find<ProfileViewModel>().logout();
        //
        //     // Reset flag so it can trigger again later
        //     _isLoggingOut = false;
        //   },
        //   child: const Text("OK"),
        // ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:()async {
              // Close the dialog
              Get.back();

              // Ensure ProfileViewModel is available

              // Log out the user
              // await Get.find<ProfileViewModel>().logout();

              // Reset flag so it can trigger again later
              _isLoggingOut = false;

            },
            style: commonElevatedButtonStyle(),

            child: Text(
              textScaler: TextScaler.linear(1.0),
              "Log In Again",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

      ],
    ),
    barrierDismissible: false,
  );
}
