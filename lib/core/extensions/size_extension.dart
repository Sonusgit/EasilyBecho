import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExtension on num {
  /// Height responsive
  double get height => this.h;

  /// Width responsive
  double get width => this.w;

  /// Font size responsive
  double get fontSp => this.sp;

  /// Radius responsive
  double get radius => this.r;
}

extension SizedBoxExtension on num {
  /// Vertical space
  Widget get verticalH => SizedBox(height: toDouble().h);

  /// Horizontal space
  Widget get horizontalW => SizedBox(width: toDouble().w);
   /// Square space (both height & width same)
  Widget get box => SizedBox(height: toDouble().h, width: toDouble().w);
}
