import 'package:http/http.dart' as http;

class ApiService {
  //  Future<dynamic> getHeader(bool authToken) async{
  //    if (authToken) {
  //      String? tokem = await SharedPreferencesHelper.getToken();
  //    }
  //  }

  Future<dynamic> requestGetForApi({required String url, bool? token}) async {
    var response = await http.get(Uri.parse(url), 
    headers: {

    });
  }
}
