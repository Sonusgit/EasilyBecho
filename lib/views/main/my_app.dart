import 'package:device_preview/device_preview.dart';
import 'package:easilybecho/core/bloc/app_bloc_provider.dart';
import 'package:easilybecho/core/navigation/routes/app_pages.dart';
import 'package:easilybecho/core/utility/themes/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(MediaQuery.of(context).size.height);
    }
    if (kDebugMode) {
      print(MediaQuery.of(context).size.width);
    }

    return MultiBlocProvider(
      providers: AppBlocProvider.providers,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            routerConfig: AppPages.routes,
            title: 'EasilyBecho',
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
