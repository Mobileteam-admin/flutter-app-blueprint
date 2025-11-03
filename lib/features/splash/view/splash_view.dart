import 'package:flutter_base_project/core/constants/app_colors.dart';
import 'package:flutter_base_project/core/constants/app_icons.dart';
import 'package:flutter_base_project/core/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_sizes.dart';
import '../view_model/splash_view_model.dart';

class SplashView extends GetView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AppSizer.layoutByOrientation(
        context: context,
        portrait: _portraitSplash(context),
        landscape: _portraitSplash(context),
      ),
    );
  }
  Widget _portraitSplash(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppIcons.logo,
          width:  AppSizer.width(context, 120),
        ),
        SizedBox(
          height: AppSizes.height23,
        ),
        CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ],
    );
  }

}
