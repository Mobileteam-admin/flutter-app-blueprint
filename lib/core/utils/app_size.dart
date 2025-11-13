import 'package:flutter/material.dart';

class AppSizer {
  /// Returns the MediaQuery data from the context
  static MediaQueryData _mediaQueryData(BuildContext context) =>
      MediaQuery.of(context);

  /// Returns screen width
  static double screenWidth(BuildContext context) =>
      _mediaQueryData(context).size.width;

  /// Returns screen height
  static double screenHeight(BuildContext context) =>
      _mediaQueryData(context).size.height;

  /// Returns true if the device is tablet (based on width)
  static bool isTablet(BuildContext context) =>
      screenWidth(context) >= 600;

  /// Returns true if orientation is portrait
  static bool isPortrait(BuildContext context) =>
      _mediaQueryData(context).orientation == Orientation.portrait;

  /// Returns height as a percentage of total screen height
  static double height(BuildContext context, double percent) =>
      screenHeight(context) * percent;

  /// Returns width as a percentage of total screen width
  static double width(BuildContext context, double percent) =>
      screenWidth(context) * percent;

  /// Returns appropriate font size based on device type
  static double fontSize(BuildContext context, double mobile, double tablet) =>
      isTablet(context) ? tablet : mobile;

  /// Returns portrait or landscape widget based on orientation
  static Widget layoutByOrientation({
    required BuildContext context,
    required Widget portrait,
    required Widget landscape,
  }) => isPortrait(context) ? portrait : landscape;

}
