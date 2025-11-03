import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/constants/app_colors.dart';
import 'package:flutter_base_project/core/constants/app_sizes.dart';

class AppInputDecoration {
  static InputDecoration inputDecoration({
    required String hintText,
    Widget? prefix, required IconButton suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: AppSizes.fontSizeSmall,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1,
        ),
      ),
      prefixIcon: prefix,
    );
  }
}
