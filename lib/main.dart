import 'package:easilybecho/routes/app_pages.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/test.dart';
import 'package:easilybecho/utility/page_not_found.dart';
import 'package:easilybecho/utility/themes/app_theme.dart';
import 'package:easilybecho/views/bill/components/bills_last_month_data_screen.dart';
import 'package:easilybecho/views/bill/components/bills_last_month_data_caeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return ScreenUtilInit(
       designSize: const Size(392.72727272727275, 872.7272727272727),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
      
        title: 'EasilyBecho',
      
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkThame,
        themeMode: ThemeMode.system,
      
        // Use system theme mode
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        unknownRoute: GetPage(
          name: AppRoutes.notFound,
          page: () => PageNotFound(),
        ),
        //  home: Test(),
      ),
    );
  }
}
