import 'package:dio/dio.dart';
import 'package:easilybecho/core/extensions/app_log_print_extention.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      '┌─────────────────────────────────────────────'.logInfo(tag: 'REQUEST');
      '│ ${options.method} ${options.uri}'.logInfo(tag: 'REQUEST');
      '│ Headers: ${options.headers}'.logInfo(tag: 'REQUEST');
      if (options.data != null) {
        '│ Body: ${options.data}'.logInfo(tag: 'REQUEST');
      }
      '└─────────────────────────────────────────────'.logInfo(tag: 'REQUEST');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      '┌─────────────────────────────────────────────'.logInfo(tag: 'RESPONSE');
      '│ ${response.statusCode} ${response.requestOptions.uri}'.logInfo(tag: 'RESPONSE');
      '│ Data: ${response.data}'.logInfo(tag: 'RESPONSE');
      '└─────────────────────────────────────────────'.logInfo(tag: 'RESPONSE');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      '┌─────────────────────────────────────────────'.logError(
        err,
        StackTrace.current,
        tag: 'ERROR',
      );
      '│ ${err.requestOptions.method} ${err.requestOptions.uri}'.logError(
        err,
        StackTrace.current,
        tag: 'ERROR',
      );
      '│ ${err.message}'.logError(err, StackTrace.current, tag: 'ERROR');
      '└─────────────────────────────────────────────'.logError(
        err,
        StackTrace.current,
        tag: 'ERROR',
      );
    }
    handler.next(err);
  }
}