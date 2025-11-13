import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base_project/core/constants/app_colors.dart';
import 'package:flutter_base_project/core/constants/app_icons.dart';
import 'package:flutter_base_project/core/constants/app_sizes.dart';
import 'package:flutter_base_project/core/constants/app_strings.dart';
import 'package:flutter_base_project/core/utils/app_size.dart';
import 'package:flutter_base_project/core/widgets/app_input_decoration.dart';
import 'package:flutter_base_project/features/login/view_model/login_view_model.dart';

import '../../../core/utils/widget_decoration.dart';

class LoginView extends GetView<LoginViewModel> {
  LoginView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: AppSizer.layoutByOrientation(
        context: context,
        portrait: _portraitLogin(context),
        landscape: _portraitLogin(context),
      ),
    ),
  );

  Widget _portraitLogin(BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(horizontal: AppSizes.padding20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                AppIcons.logo,
                width: 200,
                height: 100,
                color: AppColors.primary,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),

              // Title
              Text(
                'Welcome Back!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Login to continue',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 40),

              // Email Field
              TextFormField(
                controller: controller.emailController,
                decoration: textFormInputDecoration(
                  hintText: AppStrings.enterEmail,
                  prefix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      AppIcons.emailIcon,
                      width: 20,
                      height: 20,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: controller.validateEmail,
              ),
              const SizedBox(height: 20),

              // Password Field
              Obx(
                    () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: AppInputDecoration.inputDecoration(
                    hintText: 'Enter Password',
                    prefix:
                    const Icon(Icons.lock_outline, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  validator: controller.validatePassword,
                ),
              ),
              const SizedBox(height: 30),

              // Login Button
              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.loginWithEmail(formKey),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: AppSizes.fontSize20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
