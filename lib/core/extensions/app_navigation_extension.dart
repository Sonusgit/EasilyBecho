import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppNavigation on BuildContext {

  /// Replace current route
  void goTo(String path, {Object? extra}) {
    go(path, extra: extra);
  }

  /// Push new route (stack me add)
  void pushTo(String path, {Object? extra}) {
    push(path, extra: extra);
  }

  /// Back navigation
  void popPage<T extends Object?>([T? result]) {
    pop(result);
  }

  /// Push & remove all previous
  void goAndClear(String path, {Object? extra}) {
    go(path, extra: extra);
  }
}
