import 'dart:developer';
import 'package:flutter/foundation.dart';

extension AppLogPrintExtention on String {
  // Simple print with prefix
  void get appPrint {
    if (kDebugMode) {
      print('[Print] $this');
    }
  }

  // Custom logger with all parameters
  void appLogger({
    String tag = 'APP',
    int level = 0,
    Object? error,
    StackTrace? stackTrace,
    int? sequenceNumber,
  }) {
    if (kDebugMode) {
      log(
        this,
        name: tag,
        level: level,
        error: error,
        stackTrace: stackTrace,
        sequenceNumber: sequenceNumber,
      );
    }
  }

  // Info level logging
  void logInfo({String tag = 'APP'}) {
    if (kDebugMode) {
      log(this, name: tag, level: 0);
    }
  }

  // Warning level logging
  void logWarning({String tag = 'APP'}) {
    if (kDebugMode) {
      log(this, name: tag, level: 500);
    }
  }

  // Error level logging
  void logError(Object error, StackTrace stackTrace, {String tag = 'APP'}) {
    if (kDebugMode) {
      log(this, name: tag, level: 800, error: error, stackTrace: stackTrace);
    }
  }
}