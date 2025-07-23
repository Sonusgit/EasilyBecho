import 'package:easilybecho/utility/const/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    
  );

  static ThemeData darkThame = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,

    //card theme
    cardTheme: CardThemeData(
      // color: AppColors.textSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      )
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.infoColor,
        foregroundColor: AppColors.scaffoldBackgroundColor,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      )
    )
  );
}
