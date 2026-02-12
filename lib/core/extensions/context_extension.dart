import 'dart:io';

import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).viewInsets.bottom + kBottomNavigationBarHeight;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
  TextDirection get directionality => Directionality.of(this);


  bool get isRTL => directionality == TextDirection.rtl;
  bool get isLTR => !isRTL;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => !isDarkMode;

  bool get isIOS => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  bool get isWeb => Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  bool get isDesktop =>  Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  bool get isMobile => Platform.isAndroid || Platform.isIOS;
  bool get isWatch => Platform.isFuchsia;
  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;
  bool get isPhone => !isTablet;
  bool get isSmallScreen => MediaQuery.of(this).size.shortestSide < 481;
  bool get isMediumScreen => MediaQuery.of(this).size.shortestSide >= 481 && MediaQuery.of(this).size.shortestSide <= 720;
  bool get isLargeScreen => MediaQuery.of(this).size.longestSide > 720;
  bool get isExtraLargeScreen => MediaQuery.of(this).size.longestSide > 950;

  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  double get safeHeight => screenHeight - statusBarHeight - bottomBarHeight;
  //Focus helpers
  void unfocus() => FocusScope.of(this).unfocus();
  void requestFocus(FocusNode node) => FocusScope.of(this).requestFocus(node);

  // Responsive padding
  EdgeInsets get padding => MediaQuery.of(this).padding;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  double get defaultPadding => 16.0;

  // Responsive spacing
  double get spacing8 => screenWidth * 0.02;
  double get spacing16 => screenWidth * 0.04;
  double get spacing24 => screenWidth * 0.06;
  double get spacing32 => screenWidth * 0.08;
  double get spacing40 => screenWidth * 0.1;
  double get spacing48 => screenWidth * 0.12;
  double get spacing56 => screenWidth * 0.14;
  double get spacing64 => screenWidth * 0.16;
  double get spacing72 => screenWidth * 0.18;
  double get spacing80 => screenWidth * 0.2;


// Locale
  Locale get locale => Localizations.localeOf(this);

}
