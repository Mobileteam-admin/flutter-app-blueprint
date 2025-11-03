import 'package:flutter_base_project/core/utils/base_response.dart';
import 'package:flutter_base_project/core/widgets/custom_snackbar.dart';
class ErrorHandler {
  static void handle<T>(BaseResponse<T> response) {
    if (response.errors != null && response.errors!.isNotEmpty) {
      // Get the first error from the first field
      final firstFieldErrors = response.errors!.values.first;
      if (firstFieldErrors.isNotEmpty) {
        CustomSnackbar.error(firstFieldErrors.first);
      }
    }
    else if (response.message != null) {
      CustomSnackbar.error(response.message!);
    } else if (response.firstError != null) {
      CustomSnackbar.error(response.firstError!);
    } else {
      CustomSnackbar.error("Something went Wrong.");
    }
  }
}