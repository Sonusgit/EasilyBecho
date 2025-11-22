import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
   static const String _isLoggedInKey = 'isLoggedIn';
   static const String _jwtToken = 'token';
   static const String _userIdKey = 'userId';
   static const String _userNameKey = 'userName';
   static const String _userEmailKey = 'userEmail';
   static const String _userPhoneKey = 'userPhone';
   static const String _userAddressKey = 'userAddress';
   static const String _userImageKey = 'userImage';


   static Future<void> setIsLoggedIn(bool isLoggedIn)async{
    final SharedPreferences prefe = await SharedPreferences.getInstance();
    await prefe.setBool(_isLoggedInKey,isLoggedIn);
   }
   static Future<bool> getIsLoggedIn() async{
    final SharedPreferences prefe = await SharedPreferences.getInstance();
    return prefe.getBool(_isLoggedInKey)??false;
   }

  static Future<void> setJwtToken(String token)async{
    final SharedPreferences prefe = await SharedPreferences.getInstance();
    await prefe.setString(_jwtToken, token);
  }
  static Future<String?> getJwtToken()async{
    SharedPreferences prefe =await SharedPreferences.getInstance();
    return prefe.getString(_jwtToken);
  }
}