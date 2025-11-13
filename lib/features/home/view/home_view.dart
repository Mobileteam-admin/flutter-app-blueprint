import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base_project/core/constants/app_colors.dart';
import 'package:flutter_base_project/core/constants/app_sizes.dart';
import 'package:flutter_base_project/core/constants/app_strings.dart';
import 'package:flutter_base_project/core/utils/app_size.dart';
import 'package:flutter_base_project/features/home/view_model/home_view_model.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: AppSizer.layoutByOrientation(
        context: context,
        portrait: _portraitHome(context),
        landscape: _portraitHome(context),
      ),
    ),
  );

  Widget _portraitHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with App Name and Logout
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: controller.logout,
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Greeting
          Text(
            controller.getGreeting(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          // Dummy User Email (from login)
          Text(
            "Logged in as: ${controller.loggedInEmail}",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),

          // Dummy Dashboard Section
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dashboard, size: 60, color: Colors.blueAccent),
                    SizedBox(height: 16),
                    Text(
                      "Welcome to your Dashboard!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "This is a dummy home screen.\nAdd your real widgets here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
