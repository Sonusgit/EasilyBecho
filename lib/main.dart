import 'package:easilybecho/core/utility/utility_screen/network_controller.dart';
import 'package:easilybecho/routes/app_pages.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/test.dart';
import 'package:easilybecho/core/utility/utility_screen/page_not_found.dart';
import 'package:easilybecho/core/utility/themes/app_theme.dart';
import 'package:easilybecho/test_bloc/tast_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkController());
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
      child: ToastificationWrapper(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
        
          title: 'EasilyBecho',
        
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkThame,
          // themeMode: ThemeMode.system,
        
          // Use system theme mode
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // initialRoute: AppPages.initial,
          // getPages: AppPages.routes,
         
          // defaultTransition: Transition.fadeIn,
          // transitionDuration: Duration(milliseconds: 100),
          // unknownRoute: GetPage( 
          //   name: AppRoutes.notFound,
          //   page: () => PageNotFound(),
          // ),
           home: TastScreen(),
        ),
      ),
    );
  }
}
