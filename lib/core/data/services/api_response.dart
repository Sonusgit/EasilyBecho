import 'package:easilybecho/core/utility/const/app_enums.dart';

class ApiResponse<T> {
  final ApiStatus status;
  final String? message;
  final T? data;

  // Default constructor
  ApiResponse({this.status = ApiStatus.initial, this.message, this.data});

  ApiResponse.loading()
    : status = ApiStatus.loading,
      message = null,
      data = null;

  ApiResponse.completed({this.data, this.message}) : status = ApiStatus.success;

  ApiResponse.empty({this.message}) : status = ApiStatus.empty, data = null;

  ApiResponse.error({this.message, this.data}) : status = ApiStatus.error;
}

// sealed class ApiResponse<T> {}

// class Loading<T> extends ApiResponse<T> {}

// class Success<T> extends ApiResponse<T> {
//   final T data;
//   Success(this.data);
// }

// class Error<T> extends ApiResponse<T> {
//   final String message;
//   Error(this.message);
// }
