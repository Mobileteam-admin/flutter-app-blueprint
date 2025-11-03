import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_base_project/core/constants/app_constants.dart';
import 'package:flutter_base_project/core/utils/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/session_expire_pop_up.dart';


enum Method { POST, GET, PUT, DELETE, PATCH }

extension MethodExtension on Method {
  String get name => toString().split('.').last;
}

class HttpService {
  HttpService.internal();

  static final HttpService httpService = HttpService.internal();
  factory HttpService() => httpService;

  Dio? _dio;

  // Initialize Dio
  Future<HttpService> init() async {
    _initializeDio();
    return this;
  }



  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl+ AppConstants.apiVer,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) {
        return status != null && status < 500;
        // ✅ Allow 422, 400, 401, 403, 404 to be handled manually
      },
    ));

    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint(
          "REQUEST[${options.method}] => PATH: ${options.path} => QUERY_PARAMS: ${options.queryParameters} => BODY: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint("RESPONSE[${response.statusCode}] => DATA: ${response.data}");

        String path=response.requestOptions.path;



        if (response.statusCode == 401) {
          if (!(path.contains("/auth/verify-otp"))){
            handleUnauthorized();
            return;
          }

        }

        return handler.next(response);
      },
      onError: (error, handler) {
        debugPrint("ERROR[${error.response?.statusCode}] => ${error.message}");
        String path=error.requestOptions.path;

        if (error.response?.statusCode == 401) {
          if (!(path.contains("/auth/verify-otp"))){
            handleUnauthorized();
            return;
          }
        }

        return handler.next(error);
      },
    ));
  }

  // Standard headers
  Future<Map<String, String>> _header() async {
    final  token = await SharedPrefManager().getString(SharedPrefManager.keyToken);
    return {
      "Content-Type": "application/json",
      "accept": "application/json",
      // "X-CSRF-TOKEN": "",
      "Authorization": token.toString()?? "",
      // "softwareType": "1"
    };
  }


  // Main request method
  Future<dynamic> request({
    required String path,
    required Method method,
    Map<String, dynamic>? params,
    int retries = 2,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    if (_dio == null) throw Exception("Dio not initialized. Call init() first.");

    final online = await _hasInternet();
    if (!online) {
      print("No internet connection. Waiting to retry...");
      _retryWhenOnline(() => request(
        path: path,
        method: method,
        params: params,
        retries: retries,
        retryDelay: retryDelay,
      ));
      return "No internet connection. Will retry when online.";
    }

    final headers = await _header();
    Response response;

    for (int attempt = 0; attempt <= retries; attempt++) {
      try {
        final startTime = DateTime.now();
        print('rose1');

        response = await _performRequest(path, method, headers, params);
        print('rose2');

        final duration = DateTime.now().difference(startTime);
        print("Request succeeded in ${duration.inMilliseconds}ms");

        if ([200, 201 ,422 ,401 ,400,403,204,404,409].contains(response.statusCode)) {
          return response; // ✅ includes message from server
        }
        else {
          _handleHttpError(response);
          print("Non-200 response: ${response.statusCode}");
        }
      } catch (e) {
        print("Error on attempt ${attempt + 1}: $e");
        if (attempt == retries) return null;
      }

      await Future.delayed(retryDelay);
    }

    return null;
  }
  void _handleHttpError(Response response) {
    switch (response.statusCode) {
      case 400:
        throw Exception("Bad Request: ${response.data['message'] ?? 'Invalid request'}");
      case 401:
        throw Exception("Unauthorized: Please login again.");
      case 403:
        throw Exception("Forbidden: You do not have access.");
      case 404:
        throw Exception("Not Found: Resource does not exist.");
      case 500:
        throw Exception("Server Error: Something went wrong.");
      default:
        throw Exception("Unhandled Error: ${response.statusCode}");
    }
  }


  Future<Response> _performRequest(
      String path,
      Method method,
      Map<String, String> headers,
      Map<String, dynamic>? params,
      ) {
    switch (method) {
      case Method.POST:
        return _dio!.post(path, data: params, options: Options(headers: headers));
      case Method.PATCH:
        return _dio!.patch(path, data: params, options: Options(headers: headers));
      case Method.DELETE:
        return _dio!.delete(path, options: Options(headers: headers));
      case Method.GET:
      default:
        return _dio!.get(path, queryParameters: params, options: Options(headers: headers));
    }
  }

  // Internet connectivity check
  Future<bool> _hasInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;

    try {
      final lookup = await InternetAddress.lookup('google.com');
      return lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  // Retry logic when back online
  void _retryWhenOnline(Future<void> Function() apiCall) {
    StreamSubscription? subscription;

    subscription = Connectivity().onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        try {
          final lookup = await InternetAddress.lookup('google.com');
          if (lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty) {
            await apiCall();
            subscription?.cancel();
          }
        } catch (_) {
          // Still offline
        }
      }
    });
  }

  // Local time string
  String getLocalTimeDate() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

}
