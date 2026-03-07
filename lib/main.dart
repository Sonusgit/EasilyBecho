import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easilybecho/core/bloc/app_bloc_observer.dart';
import 'package:easilybecho/core/data/network/connectivity_manager.dart';
import 'package:easilybecho/core/data/network/connectivity_wrapper.dart';
import 'package:easilybecho/core/di/injection.dart';
import 'package:easilybecho/views/main/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();
  await dotenv.load(fileName: ".env");

  // ✅ Initialize connectivity before app start
  await ConnectivityManager().initialize();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (BuildContext context) {
        return ConnectivityWrapper(showBanner: true, child: const MyApp());
      },
    ),
  );
}
