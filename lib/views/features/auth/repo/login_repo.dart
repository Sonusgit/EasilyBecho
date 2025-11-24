import 'package:easilybecho/core/helpers/toast_helper.dart';
import 'package:easilybecho/services/api_service.dart';
import 'package:easilybecho/services/app_config.dart';

class LoginRepo {

 final ApiService _apiService = ApiService();
 final AppConfig _appConfig = AppConfig();  

 Future<dynamic> login(String email, String password) async {
    try {
      final response = await _apiService.requestPosForApi(
       authToken: false,
       url:"https://backend-production-91e4.up.railway.app/login/jwt",
       dictParameter: {
         "email": email,
         "password": password
       }
     );

     if (response != null && response.statusCode == 200 ) {
       return response;
     }
    } catch (e) {
      ToastHelper.error(message:e.toString() );
    }
  }
}