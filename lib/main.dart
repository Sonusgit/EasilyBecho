import 'package:device_preview/device_preview.dart';
import 'package:easilybecho/core/charts/example_charts.dart';
import 'package:easilybecho/core/utility/utility_screen/network_controller.dart';
import 'package:easilybecho/routes/app_pages.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/services/environment_config.dart';
import 'package:easilybecho/test_screen.dart';
import 'package:easilybecho/core/utility/utility_screen/page_not_found.dart';
import 'package:easilybecho/core/utility/themes/app_theme.dart';
import 'package:easilybecho/test_bloc/tast_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
    // await dotenv.load(fileName: EnvironmentConfig.baseUrl);
     await dotenv.load(fileName: ".env");
  runApp(
    DevicePreview(
      enabled: true,
      builder: (BuildContext context) {
        return MyApp();
      },
    ),
  );
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'EasilyBecho',

          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkThame,
          // themeMode: ThemeMode.system,

          home: ChartsExamplePage(),
        ),
      ),
    );
  }
}
