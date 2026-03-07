import 'package:easilybecho/core/data/services/api_response.dart';
import 'package:easilybecho/views/features/auth/models/login_request.dart';
import 'package:easilybecho/views/features/auth/models/login_response_model.dart';
import 'package:easilybecho/views/features/auth/models/signup_request.dart';
import 'package:easilybecho/views/features/auth/models/signup_response.dart';

abstract class AuthRepo {
  Future<ApiResponse<LoginResponse>> login(LoginRequest request);
  Future<ApiResponse<SignupResponse>> signup(SignupRequest request);
  Future<ApiResponse<void>> logout();
}