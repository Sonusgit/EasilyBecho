import 'package:easilybecho/core/data/error/app_exception.dart';
import 'package:easilybecho/core/data/configs/api_constants.dart';
import 'package:easilybecho/core/data/services/api_response.dart';
import 'package:easilybecho/core/data/services/api_service.dart';
import 'package:easilybecho/views/features/auth/models/login_request.dart';
import 'package:easilybecho/views/features/auth/models/login_response_model.dart';
import 'package:easilybecho/views/features/auth/models/signup_request.dart';
import 'package:easilybecho/views/features/auth/models/signup_response.dart';
import 'package:easilybecho/views/features/auth/repo/auth_repo.dart';

class SignupRepo implements AuthRepo {
  final ApiService _apiService = ApiService();

  @override
  Future<ApiResponse<SignupResponse>> signup(SignupRequest request) async {
    try {
      final data = await _apiService.postApi(
        endpoint: ApiConstants.register,
        data: request.toJson(),
      );

      final response = SignupResponse.fromJson(
        Map<String, dynamic>.from(data as Map),
      );

      return ApiResponse.completed(data: response, message: 'Account created successfully');
    } on AppException catch (e) {
      return ApiResponse.error(message: e.message);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<LoginResponse>> login(LoginRequest request) =>
      throw UnimplementedError('Use LoginRepo for login');

  @override
  Future<ApiResponse<void>> logout() =>
      throw UnimplementedError('Use LogoutRepo for logout');
}