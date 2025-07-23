import 'dart:convert';

import 'package:easilybecho/utility/shared_preferences_utility.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<T?> requestGetApi<T>({
    required String url,
    required bool token,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    try {
      print('Requesting GET: $uri');
      // final headers = getHeader(token);
      final response = await http
          .get(uri, headers: await getHeader(token))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        print('Response data: ${response.body}');
        if (fromJson != null) {
          return fromJson(jsonDecode(response.body));
        } else {
          return null;
        }
        // 🔄 Better to return data
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {}
  }

  static Future<dynamic> requestPostApi(String url, dynamic data) async {
   try {
      http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      final decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      print('Rrequest failed with Status: ${response.statusCode}');
    }
   } catch (e) {
     print('Error occurred: $e');
   }
  }

  static Future<Map<String, String>> getHeader(bool token) async {
    if (token) {
      String? userToken = await SharedPreferencesUtility.getUserToken();
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': ' Bearer $userToken',
      };
    } else {
      return {"Content-type": "application/json", "Accept": "application/json"};
    }
  }
}
