import 'package:frontend/core/network/api_client.dart';
import '../models/user_model.dart';

class AuthRepository {
  Future<AuthResponse> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
    String phone = '',
    String preferredLanguage = 'en',
  }) async {
    final response = await ApiClient.dio.post(
      'accounts/register/',
      data: {
        'full_name': fullName,
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
        'preferred_language': preferredLanguage,
      },
    );

    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    final response = await ApiClient.dio.post(
      'accounts/login/',
      data: {
        'username': username,
        'password': password,
      },
    );

    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
