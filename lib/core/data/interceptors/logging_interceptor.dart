import 'package:dio/dio.dart';
import 'package:easilybecho/core/extensions/app_log_Print_extention.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    '${options.method} → ${options.uri}'.logInfo(tag: 'REQUEST');
    if (options.queryParameters.isNotEmpty)
      'Params → ${options.queryParameters}'.logInfo(tag: 'REQUEST');
    if (options.data != null) 'Body → ${options.data}'.logInfo(tag: 'REQUEST');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    '${response.statusCode} → ${response.requestOptions.uri}'.logInfo(
      tag: 'RESPONSE',
    );
    'Data → ${response.data}'.logInfo(tag: 'RESPONSE');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ✅ Log: status code + url + server message
    final status = err.response?.statusCode ?? 'N/A';
    final url = err.requestOptions.uri;
    final message =
        err.response?.data?['message'] ?? err.message ?? 'Unknown error';
    '$status → $url | $message'.logError(err, StackTrace.current, tag: 'ERROR');
    handler.next(err);
  }
}
