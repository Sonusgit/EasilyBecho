import 'package:easilybecho/utility/const/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xffffffff),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightCardsColor,
        foregroundColor: AppColors.lightThemeTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
    //card theme
    cardTheme: CardThemeData(
      elevation: 0.2,
      color: AppColors.lightCardsColor,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    ),
  );

  static ThemeData darkThame = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,

    //card theme
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.darkCardsColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff212121),
        foregroundColor: AppColors.scaffoldBackgroundColor,

        // iconColor: ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  );
}
