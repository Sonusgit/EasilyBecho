import 'package:easilybecho/core/data/error/app_exception.dart';
import 'package:easilybecho/core/data/configs/api_constants.dart';
import 'package:easilybecho/core/data/services/api_response.dart';
import 'package:easilybecho/core/data/services/api_service.dart';
import 'package:easilybecho/core/data/services/secure_storage_helper.dart';
import 'package:easilybecho/views/features/auth/models/login_request.dart';
import 'package:easilybecho/views/features/auth/models/login_response_model.dart';
import 'package:easilybecho/views/features/auth/models/signup_request.dart';
import 'package:easilybecho/views/features/auth/models/signup_response.dart';
import 'package:easilybecho/views/features/auth/repo/auth_repo.dart';

class LoginRepo implements AuthRepo {
  final ApiService _apiService = ApiService();

  @override
  Future<ApiResponse<LoginResponse>> login(LoginRequest request) async {
    try {
      final data = await _apiService.postApi(
        endpoint: ApiConstants.login,
        data: request.toJson(),
      );

      final response = LoginResponse.fromJson(
        Map<String, dynamic>.from(data as Map),
      );

      await SecureStorageHelper.saveUserData(
        accessToken: response.accessToken,
        userId: response.userId,
        email: response.email,
        name: response.name,
        phone: response.phone,
      );

      return ApiResponse.completed(data: response, message: 'Login successful');
    } on AppException catch (e) {
      return ApiResponse.error(message: e.message);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<SignupResponse>> signup(SignupRequest request) =>
      throw UnimplementedError('Use SignupRepo for signup');

  @override
  Future<ApiResponse<void>> logout() =>
      throw UnimplementedError('Use LogoutRepo for logout');
}