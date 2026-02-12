// import 'dart:developer';

// import 'package:easilybecho/services/api_model.dart';
// import 'package:easilybecho/services/api_service.dart';
// import 'package:easilybecho/learn_bloc/test_bloc/repo/test_repo/test_repo.dart';

// class TestApiRepo implements TestRepo {
//   // ApiService apiService = ApiService();

//   @override
//   Future<ApiModel> getProductData() async {
//     try {
//       final response = await apiService.get(
//         url: "https://jsonplaceholder.typicode.com/posts",
//         dictParameter: null,
//         authToken: true, endpoint: '',
//       );
//       log(response.toString());
//       final bool success =
//           response!.data != null && (response.data as List).isNotEmpty;
//       final String msg = success ? "success" : "failed";
//       return ApiModel(
//         status: success,
//         message: msg,
//         data: success ? response.data : null,
//       );
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<ApiModel> postData() {
//     // TODO: implement postData
//     throw UnimplementedError();
//   }
// }
