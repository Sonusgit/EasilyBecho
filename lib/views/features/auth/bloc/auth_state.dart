import 'package:easilybecho/core/data/services/api_response.dart';
import 'package:easilybecho/views/features/auth/models/login_response_model.dart';
import 'package:easilybecho/views/features/auth/models/signup_response.dart';

class AuthState {
  final ApiResponse<LoginResponse> loginResponse;
  final ApiResponse<SignupResponse> signupResponse;
  final ApiResponse<void> logoutResponse;

  const AuthState({
    required this.loginResponse,
    required this.signupResponse,
    required this.logoutResponse,
  });

  factory AuthState.initial() => AuthState(
    loginResponse: ApiResponse(),
    signupResponse: ApiResponse(),
    logoutResponse: ApiResponse(),
  );

  AuthState copyWith({
    ApiResponse<LoginResponse>? loginResponse,
    ApiResponse<SignupResponse>? signupResponse,
    ApiResponse<void>? logoutResponse,
  }) => AuthState(
    loginResponse: loginResponse ?? this.loginResponse,
    signupResponse: signupResponse ?? this.signupResponse,
    logoutResponse: logoutResponse ?? this.logoutResponse,
  );
}
