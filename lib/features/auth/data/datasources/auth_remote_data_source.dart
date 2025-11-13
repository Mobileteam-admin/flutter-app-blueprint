import 'package:dio/dio.dart';
import '../../../../core/storage/shared_prefs.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<String?> refreshToken(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;
  final SharedPrefManager prefs;
  AuthRemoteDataSourceImpl({required this.client, required this.prefs});

  @override
  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@example.com' && password == 'password') {
      // Save tokens
      await prefs.setBool(SharedPrefManager.keyLogin, true);
      await prefs.setString(SharedPrefManager.keyToken, 'valid_access_token');
      await prefs.setString(SharedPrefManager.keyRefresh, 'valid_refresh_token');
      return const UserModel(id: '1', name: 'Test User', email: 'test@example.com');
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<String?> refreshToken(String refreshToken) async {
    await Future.delayed(const Duration(seconds: 1));
    if (refreshToken == 'valid_refresh_token') {
      // Return new access token
      await prefs.setString(SharedPrefManager.keyToken, 'new_access_token');
      return 'new_access_token';
    }
    // failed to refresh
    return null;
  }
}
