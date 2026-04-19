import '../data/models/user_model.dart';

class AuthState {
  final bool isLoading;
  final String? token;
  final UserModel? user;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.token,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    String? token,
    UserModel? user,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      user: user ?? this.user,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
