import 'dart:developer';

import 'package:flutter/foundation.dart';

extension AppLogPrintExtention on String {
  void get appPrint {
    if (kDebugMode) {
      print('[Print] $this');
    }
  }

  void appLogger({
    String tag = 'APP',
    int level = 0,
    Object? error,
    int? sequenceNumber,
  }) {
    if (kDebugMode) {
      log(
        this,
      //  '[L:$level] $this',

        name: tag,
        level: level,
        error: error,
        sequenceNumber: sequenceNumber,
      );
    }
  }

  void logInfo({String tag = 'APP'}) {
    if (kDebugMode) {
      log(this, name: tag, level: 0);
    }
  }

  void logWarning({String tag = 'APP'}) {
    if (kDebugMode) {
      log(this, name: tag, level: 500);
    }
  }

  void logError(Object error, StackTrace stackTrace, {String tag = 'APP'}) {
    if (kDebugMode) {
      log(this, name: tag, level: 800, error: error, stackTrace: stackTrace);
    }
  }
}
