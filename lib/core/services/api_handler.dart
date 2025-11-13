import 'dart:typed_data';
import 'package:flutter_base_project/core/constants/api_constants.dart';
import 'package:flutter_base_project/core/constants/app_constants.dart';
import 'package:flutter_base_project/core/services/http_service.dart';
import 'package:flutter_base_project/core/utils/base_response.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;


class ApiHandler {
  ApiHandler.internal();

  static final ApiHandler apiHandler = ApiHandler.internal();

  final HttpService _http = HttpService();

  /// Example: Request OTP
  Future<BaseResponse<void>> requestOtp(Map<String, dynamic> params) async {
    final res = await _http.request(
      path: ApiConstants.requestOtpEndpoint,
      method: Method.POST,
      params: {
        ...params, // Spread the provided params (either phone or email)
        "role": AppConstants.appRole,
      },
    );

    if (res is! Response) {
      throw Exception("Unexpected error occurred");
    }

    return BaseResponse<void>.fromJson(res.data, (_) {});
  }

  Future<BaseResponse<void>> signUp(
    String phone,
    String name,
    String email,
  ) async {
    final res = await _http.request(
      path: ApiConstants.signUpEndpoint,
      method: Method.POST,
      params: {
        "name": name,
        "phone": phone,
        "email": email,
        "role": AppConstants.appRole,
      },
    );

    if (res is! Response) {
      throw Exception("Unexpected error occurred");
    }

    return BaseResponse<void>.fromJson(res.data, (_) {});
  }



  // get single menu item


  // ==================





}
