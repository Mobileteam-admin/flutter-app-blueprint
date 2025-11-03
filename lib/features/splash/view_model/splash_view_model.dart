import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../core/utils/local_storage.dart';
import '../../../routes/app_routes.dart';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();

    _startSplashTimer();
  }

  @override
  void onReady() {
    super.onReady();
    _hideKeyboard();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }



  void _startSplashTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    await _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn =await SharedPrefManager().getBool(SharedPrefManager.keyLogin) ??false;

    if (isLoggedIn) {
      Get.offAllNamed<void>(AppRoutes.home); // Navigate to HomeView
      // Get.find<HomeViewModel>().loadApiWithToken(); //<-->
    } else {
      Get.offAllNamed<void>(AppRoutes.login); // Navigate to LoginView
    }
  }
}
