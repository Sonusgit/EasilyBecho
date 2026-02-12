import 'package:easilybecho/core/di/injection.dart';
import 'package:easilybecho/core/extensions/app_log_print_extention.dart';
import 'package:easilybecho/core/network/configs/api_constants.dart';
import 'package:easilybecho/core/network/services/api_service.dart';
import 'package:easilybecho/core/network/services/secure_storage_helper.dart';
import 'package:easilybecho/views/features/auth/models/login_request.dart';
import 'package:easilybecho/views/features/auth/models/login_response_model.dart';

class AuthRepository {
  final ApiService _apiService = getIt<ApiService>();

  // Login
  Future<LoginResponseModel?> login(LoginRequest request) async {
    try {
      "Login attempt for: ${request.email}".logInfo(tag: 'AuthRepository');

      final response = await _apiService.post(
        endpoint: ApiConstants.login,
        data: request.toJson(),
        requiresAuth: false,
      );

      if (response == null) {
        "Login failed - No response".logWarning(tag: 'AuthRepository');
        return null;
      }

      final loginResponse = LoginResponseModel.fromJson(response.data);

      if (response.statusCode == 200 && loginResponse.payload != null) {
        // Save user data
        await _saveUserData(loginResponse.payload!);

        // Initialize auth interceptor
        _apiService.initAuth();

        "Login successful for: ${request.email}".logInfo(tag: 'AuthRepository');
      }

      return loginResponse;
    } catch (e, stackTrace) {
      "Login error".logError(e, stackTrace, tag: 'AuthRepository');
      return null;
    }
  }

  // Save user data to secure storage
  Future<void> _saveUserData(UserData userData) async {
    await SecureStorageHelper.saveUserData(
      accessToken: userData.accessToken,
      userId: userData.userId,
      email: userData.email,
      phone: userData.phone,
      name: userData.name,
    );
  }

  // Logout
  Future<void> logout() async {
    try {
      "Logout initiated".logInfo(tag: 'AuthRepository');

      await _apiService.post(
        endpoint: ApiConstants.logout,
        requiresAuth: true,
        showToast: false,
      );

      // Clear storage and remove auth
      await SecureStorageHelper.clearAllUserData();
      _apiService.removeAuth();

      "Logout successful".logInfo(tag: 'AuthRepository');
    } catch (e, stackTrace) {
      "Logout error".logError(e, stackTrace, tag: 'AuthRepository');

      // Even if API fails, clear local data
      await SecureStorageHelper.clearAllUserData();
      _apiService.removeAuth();
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await SecureStorageHelper.isAuthenticated();
  }
}
