// // lib/services/token_manager.dart
// import 'dart:developer' show log;
// import 'package:shared_preferences/shared_preferences.dart';

// class TokenManager {
//   static const String _keyAccessToken = 'access_token';
//   static const String _keyRefreshToken = 'refresh_token';
//   static const String _keyTokenExpiry = 'token_expiry';

//   // Save both tokens
//   static Future<void> saveTokens({
//     required String accessToken,
//     required String refreshToken,
//     int? expiresIn, // in seconds
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyAccessToken, accessToken);
//     await prefs.setString(_keyRefreshToken, refreshToken);

//     if (expiresIn != null) {
//       final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
//       await prefs.setString(_keyTokenExpiry, expiryTime.toIso8601String());
//     }

//     log("✅ Tokens saved successfully");
//   }

//   // Get Access Token
//   static Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyAccessToken);
//   }

//   // Get Refresh Token
//   static Future<String?> getRefreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyRefreshToken);
//   }

//   // Check if access token is expired
//   static Future<bool> isTokenExpired() async {
//     final prefs = await SharedPreferences.getInstance();
//     final expiryString = prefs.getString(_keyTokenExpiry);

//     if (expiryString == null) return false;

//     final expiryTime = DateTime.parse(expiryString);
//     final now = DateTime.now();

//     // Consider token expired 5 minutes before actual expiry
//     final isExpired = now.isAfter(expiryTime.subtract(Duration(minutes: 5)));

//     log("Token expired: $isExpired");
//     return isExpired;
//   }

//   // Clear all tokens
//   static Future<void> clearTokens() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyAccessToken);
//     await prefs.remove(_keyRefreshToken);
//     await prefs.remove(_keyTokenExpiry);
//     log("🗑️ Tokens cleared");
//   }

//   // Update only access token (after refresh)
//   static Future<void> updateAccessToken(String accessToken, {int? expiresIn}) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyAccessToken, accessToken);

//     if (expiresIn != null) {
//       final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
//       await prefs.setString(_keyTokenExpiry, expiryTime.toIso8601String());
//     }

//     log("✅ Access token updated");
//   }
// }

// lib/services/token_manager.dart
import 'dart:developer';
import 'secure_storage.dart';

class TokenManager {
  static const _accessToken = 'access_token';
  static const _refreshToken = 'refresh_token';
  static const _expiry = 'token_expiry';

  /// Save tokens
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) async {
    final expiryTime = DateTime.now()
        .add(Duration(seconds: expiresIn))
        .toIso8601String();

    await SecureStorage.write(_accessToken, accessToken);
    await SecureStorage.write(_refreshToken, refreshToken);
    await SecureStorage.write(_expiry, expiryTime);

    log("✅ Tokens saved securely");
  }

  static Future<String?> getAccessToken() => SecureStorage.read(_accessToken);

  static Future<String?> getRefreshToken() => SecureStorage.read(_refreshToken);

  /// Token expiry check (5 min buffer)
  static Future<bool> isTokenExpired() async {
    final expiry = await SecureStorage.read(_expiry);
    if (expiry == null) return false;

    final expiryTime = DateTime.parse(expiry);
    final now = DateTime.now();

    final expired = now.isAfter(
      expiryTime.subtract(const Duration(minutes: 5)),
    );

    log("⏰ Token expired: $expired");
    return expired;
  }

  static Future<void> updateAccessToken(
    String accessToken,
    int expiresIn,
  ) async {
    final expiryTime = DateTime.now()
        .add(Duration(seconds: expiresIn))
        .toIso8601String();

    await SecureStorage.write(_accessToken, accessToken);
    await SecureStorage.write(_expiry, expiryTime);

    log("🔄 Access token updated");
  }

  static Future<void> clearTokens() async {
    await SecureStorage.clear();
    log("🗑️ Tokens cleared");
  }
}
