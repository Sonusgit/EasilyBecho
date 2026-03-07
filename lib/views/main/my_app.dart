import 'package:device_preview/device_preview.dart';
import 'package:easilybecho/core/bloc/app_bloc_provider.dart';
import 'package:easilybecho/core/data/network/connectivity_manager.dart';
import 'package:easilybecho/core/data/network/no_internet_dialog%20.dart';
import 'package:easilybecho/core/navigation/app_key.dart';
import 'package:easilybecho/core/navigation/routes/app_pages.dart';
import 'package:easilybecho/core/utility/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Snackbar: shows red/green bar at top of bottom nav
      // Bottom sheet: auto shows when internet off, auto closes when on
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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