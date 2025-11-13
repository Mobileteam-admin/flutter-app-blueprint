import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/local_storage.dart';
import '../../../core/widgets/custom_snackbar.dart';

class LoginViewModel extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    if (!value.isEmail) {
      return "Invalid email format";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  Future<void> loginWithEmail(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2)); // simulate network delay

    // Dummy credentials
    const dummyEmail = "admin@mail.com";
    const dummyPassword = "123456";

    if (emailController.text.trim() == dummyEmail &&
        passwordController.text.trim() == dummyPassword) {
      SharedPrefManager().setBool(SharedPrefManager.keyLogin, true);
      CustomSnackbar.success("Login Successful!");
      // Navigate to dashboard/home page
      // Get.offAllNamed('/home');
      Get.offAllNamed('/home', arguments: {'email': emailController.text.trim()});

    } else {
      CustomSnackbar.error("Invalid email or password");
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
