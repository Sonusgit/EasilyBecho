import 'package:easilybecho/core/utility/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor:  Colors.grey[50],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightCardsColor,
        foregroundColor: AppColors.lightThemeTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
//     //card theme
    cardTheme: CardThemeData(
      elevation: 3,
      color: Colors.white,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(8.0),
      //   side: BorderSide(color: Colors.grey.shade300),
      // ),
    ),
  );

  static ThemeData darkThame = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.scaffoldBackgroundColor),
      systemOverlayStyle:SystemUiOverlayStyle(
        statusBarColor: const Color.fromARGB(255, 255, 0, 0),
        statusBarIconBrightness: Brightness.dark,
      ) ,
      backgroundColor: Color.fromARGB(255, 203, 3, 3),
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: AppColors.scaffoldBackgroundColor),
      actionsPadding: EdgeInsets.all( 8.0),
      toolbarHeight: 64.0,
      titleSpacing: 16.0,
      leadingWidth: 72.0,
      foregroundColor: Color( 0xff212121),
      titleTextStyle: TextStyle(
        color: AppColors.scaffoldBackgroundColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),

    //card theme
    cardTheme: CardThemeData(
      elevation: 3.0,
      color: AppColors.darkCardsColor,
                  shadowColor: Colors.transparent,
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
