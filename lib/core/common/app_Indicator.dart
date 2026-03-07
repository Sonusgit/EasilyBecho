import 'package:easilybecho/core/utility/const/app_colors.dart';
import 'package:flutter/material.dart';

class AppIndicator {
  static Widget circularProgress({Color? backgroundColor}) {
    return CircularProgressIndicator.adaptive(backgroundColor: backgroundColor);
  }

  static Widget linearProgress({Color? backgroundColor}) {
    return LinearProgressIndicator();
  }

  static Widget refreshIndicator({
    required Future<void> Function() onRefresh,
    required Widget child,
  }) {
    return RefreshIndicator.adaptive(onRefresh: onRefresh, child: child,
    color: AppColors.primaryColor,
    );
  }
}
