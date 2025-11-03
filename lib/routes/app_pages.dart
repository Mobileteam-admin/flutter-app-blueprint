import 'package:flutter/material.dart';

import '../features/splash/view_model/splash_view_model.dart';
import 'app_routes.dart';
import 'package:flutter_base_project/features/splash/splash_binding.dart';
import 'package:flutter_base_project/features/login/login_binding.dart';
import 'package:flutter_base_project/features/login/view/login_view.dart';
import 'package:flutter_base_project/features/home/home_binding.dart';
import 'package:flutter_base_project/features/home/view/home_view.dart';
import 'package:flutter_base_project/features/splash/view/splash_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    // Routes will be inserted here
    GetPage<SplashView>(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: BindingsBuilder<SplashViewModel>(() => Get.put(SplashViewModel())),
    ),



    GetPage<HomeView>(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),


    GetPage<LoginView>(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),


  ];





  static final unknownRoute = GetPage<void>(
    name: AppRoutes.unknown,
    page: () => const Scaffold(
      body: Center(
        child: Text("Page not found"),
      ),
    ),
  );
}
