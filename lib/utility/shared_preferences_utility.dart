import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtility {
  // Keys for shared preferences
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userTokenKey = 'userToken';
  static const String loginDateKey = 'loginDate';
  static const String userEmailKey = 'userEmail';

  /// Save user token
  static Future<void> saveIsLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  /// get user token
  static Future<bool> getIsLoggedin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  /// Save user user token
  static Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userTokenKey, token);
  }

  /// Get user token
  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTokenKey);
  }

  // save login date
  static Future<void> saveLoginDate(List<int> loginDate) async {
    final prefs = await SharedPreferences.getInstance();
    String loginDateJson = jsonEncode(loginDate);
    prefs.setString(loginDateKey, loginDateJson);
  }

  // get login date
  static Future<List<int>?> getLoginDate() async {
    final prefs = await SharedPreferences.getInstance();
    String? loginJson = prefs.getString(loginDateKey);
    if (loginJson != null) {
      return List.from(jsonDecode(loginJson));
    } else {
      return null;
    }
  }

  /// clear all shared preferences
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('Shared preferences cleared logout $prefs');
  }
}
