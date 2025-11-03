import 'package:flutter_base_project/core/constants/app_colors.dart';
import 'package:flutter_base_project/core/constants/app_sizes.dart';
import 'package:flutter_base_project/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

InputDecoration textFormInputDecoration({String? hintText, required Padding prefix}) {
  return InputDecoration(
    hintText: hintText ?? AppStrings.customizeYourMeal,
    hintStyle: TextStyle(
      color: Colors.grey.shade400,
      fontSize: AppSizes.fontSizeSmall,
    ),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

ButtonStyle commonElevatedButtonStyle({
  Color backgroundColor = AppColors.primary, // Default color
  Color foregroundColor = Colors.white,      // Default text/icon color
  double borderRadius = AppSizes.radius30, // Default border radius
  bool hasBorder = false,                   // Default no border
  Color borderColor = AppColors.primary,     // Default border color
  double minimumHeight = 48,                 // Default minimum height
}) {
  return ElevatedButton.styleFrom(
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    minimumSize: Size.fromHeight(minimumHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: hasBorder ? BorderSide(color: borderColor) : BorderSide.none,
    ),
  );
}