import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();
  
  static const String _keyUserToken = 'user_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserPhone = 'user_phone';
  static const String _keyUserName = 'user_name';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyIsFirstTime = 'is_first_time';

  // First Time Setup
  static Future<void> setIsFirstTime(bool isFirstTime) async {
    await _storage.write(key: _keyIsFirstTime, value: isFirstTime.toString());
  }

  static Future<bool> isFirstTime() async {
    final value = await _storage.read(key: _keyIsFirstTime);
    return value == null ? true : value == 'true';
  }

  // Token Management
  static Future<void> setUserToken(String accessToken) async {
    await _storage.write(key: _keyUserToken, value: accessToken);
  }

  static Future<String?> getUserToken() async {
    return await _storage.read(key: _keyUserToken);
  }

  static Future<void> clearUserToken() async {
    await _storage.delete(key: _keyUserToken);
  }

  // User ID
  static Future<void> setUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  // User Email
  static Future<void> setUserEmail(String email) async {
    await _storage.write(key: _keyUserEmail, value: email);
  }

  static Future<String?> getUserEmail() async {
    return await _storage.read(key: _keyUserEmail);
  }

  // User Phone
  static Future<void> setUserPhone(String phone) async {
    await _storage.write(key: _keyUserPhone, value: phone);
  }

  static Future<String?> getUserPhone() async {
    return await _storage.read(key: _keyUserPhone);
  }

  // User Name
  static Future<void> setUserName(String name) async {
    await _storage.write(key: _keyUserName, value: name);
  }

  static Future<String?> getUserName() async {
    return await _storage.read(key: _keyUserName);
  }

  // Login Status
  static Future<void> setLoginStatus(bool isLoggedIn) async {
    await _storage.write(key: _keyIsLoggedIn, value: isLoggedIn.toString());
  }

  static Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _keyIsLoggedIn);
    return value == 'true';
  }

  // Save User Data
  static Future<void> saveUserData({
    required String accessToken,
    required String userId,
    String? email,
    String? phone,
    String? name,
  }) async {
    await setUserToken(accessToken);
    await setUserId(userId);
    if (email != null) await setUserEmail(email);
    if (phone != null) await setUserPhone(phone);
    if (name != null) await setUserName(name);
    await setLoginStatus(true);
  }

  // Clear All User Data
  static Future<void> clearAllUserData() async {
    await _storage.delete(key: _keyUserToken);
    await _storage.delete(key: _keyUserId);
    await _storage.delete(key: _keyUserEmail);
    await _storage.delete(key: _keyUserPhone);
    await _storage.delete(key: _keyUserName);
    await _storage.delete(key: _keyIsLoggedIn);
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final accessToken = await getUserToken();
    final isLoggedIn = await SecureStorageHelper.isLoggedIn();
    return accessToken != null && accessToken.isNotEmpty && isLoggedIn;
  }
}