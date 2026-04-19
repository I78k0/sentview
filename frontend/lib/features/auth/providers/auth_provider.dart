import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository.dart';
import 'auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<void> loadSavedAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('auth_token');

    state = state.copyWith(
      token: savedToken,
      isLoading: false,
    );
  }

  Future<void> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
    String phone = '',
    String preferredLanguage = 'en',
  }) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);

      final response = await _repository.register(
        fullName: fullName,
        username: username,
        email: email,
        password: password,
        phone: phone,
        preferredLanguage: preferredLanguage,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', response.token);

      state = state.copyWith(
        isLoading: false,
        token: response.token,
        user: response.user,
      );
    } on DioException catch (e) {
      final serverMessage = e.response?.data is Map
          ? e.response?.data['message']?.toString()
          : null;

      state = state.copyWith(
        isLoading: false,
        errorMessage: serverMessage ?? e.message ?? 'Registration failed',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);

      final response = await _repository.login(
        username: username,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', response.token);

      state = state.copyWith(
        isLoading: false,
        token: response.token,
        user: response.user,
      );
    } on DioException catch (e) {
      final serverMessage = e.response?.data is Map
          ? e.response?.data['message']?.toString()
          : null;

      state = state.copyWith(
        isLoading: false,
        errorMessage: serverMessage ?? e.message ?? 'Login failed',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    state = const AuthState();
  }
}
