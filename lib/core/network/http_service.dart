import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import '../storage/shared_prefs.dart';
import '../utils/snackbar_service.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  HttpService.internal();
  static final HttpService _instance = HttpService.internal();
  factory HttpService() => _instance;

  Dio? _dio;
  final _refreshLock = Lock();

  Future<HttpService> init() async {
    _initializeDio();
    return this;
  }

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) => status != null && status < 500,
    ));

    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // add headers
        final token = SharedPrefManager().getString(SharedPrefManager.keyToken) ?? '';
        options.headers['Authorization'] = token;
        debugPrint('REQUEST[${options.method}] ${options.path} | headers: ${options.headers}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('RESPONSE[${response.statusCode}] ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (error, handler) async {
        debugPrint('ERROR[${error.response?.statusCode}] ${error.requestOptions.path}');
        if (error.response?.statusCode == 401) {
          // try refresh token once
          final shouldRetry = await _handle401(error.requestOptions);
          if (shouldRetry) {
            try {
              final opts = error.requestOptions;
              final cloneReq = await _dio!.fetch(opts);
              return handler.resolve(cloneReq);
            } catch (e) {
              // fallback
              SnackbarService.showError('Session expired. Please login again.');
              return handler.next(error);
            }
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<bool> _handle401(RequestOptions failedOptions) async {
    // Use a lock to prevent multiple refreshes
    if (_refreshLock.locked) {
      // wait until unlocked and assume refreshed
      await _refreshLock.wait();
      return true;
    }

    await _refreshLock.acquire();
    try {
      // simulate refresh token call
      final refreshToken = SharedPrefManager().getString(SharedPrefManager.keyRefresh);
      await Future.delayed(const Duration(seconds: 1)); // simulate network call
      if (refreshToken == 'valid_refresh_token') {
        // simulate new access token
        await SharedPrefManager().setString(SharedPrefManager.keyToken, 'new_access_token');
        return true;
      } else {
        // cannot refresh; clear session
        await SharedPrefManager().setBool(SharedPrefManager.keyLogin, false);
        SnackbarService.showError('Session expired. Please login again.');
        return false;
      }
    } finally {
      _refreshLock.release();
    }
  }

  Future<dynamic> request({
    required String path,
    required Method method,
    Map<String, dynamic>? params,
  }) async {
    if (_dio == null) throw Exception('Dio not initialized');
    final connectivity = Connectivity();
    final conn = await connectivity.checkConnectivity();
    if (conn == ConnectivityResult.none) {
      SnackbarService.showError('No internet connection.');
      throw Exception('No internet');
    }

    Response response;
    try {
      switch (method) {
        case Method.POST:
          response = await _dio!.post(path, data: params);
          break;
        case Method.GET:
          response = await _dio!.get(path, queryParameters: params);
          break;
        case Method.PUT:
          response = await _dio!.put(path, data: params);
          break;
        case Method.DELETE:
          response = await _dio!.delete(path);
          break;
        case Method.PATCH:
          response = await _dio!.patch(path, data: params);
          break;
      }

      return response;
    } on SocketException {
      SnackbarService.showError('Network error. Please try later.');
      rethrow;
    } on DioException catch (e) {
      rethrow;
    }
  }
}

// Simple lock implementation
class Lock {
  bool locked = false;
  final List<Completer<void>> _waiters = [];

  Future<void> acquire() async {
    if (locked) {
      final c = Completer<void>();
      _waiters.add(c);
      await c.future;
    }
    locked = true;
  }

  void release() {
    locked = false;
    if (_waiters.isNotEmpty) {
      final c = _waiters.removeAt(0);
      c.complete();
    }
  }

  Future<void> wait() async {
    if (locked) {
      final c = Completer<void>();
      _waiters.add(c);
      await c.future;
    }
  }
}
