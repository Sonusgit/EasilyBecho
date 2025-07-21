import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<T?> requestGetApi<T>({
    required String url,
    String? token,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    try {
      print('Requesting GET: $uri');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(uri, headers: headers).timeout(const Duration(seconds: 10));

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
      return response.body;
    } else {
      print('Rrequest failed with Status: ${response.statusCode}');
    }
  }
}
