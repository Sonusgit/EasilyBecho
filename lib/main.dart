import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easilybecho/core/bloc/app_bloc_observer.dart';
import 'package:easilybecho/views/main/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
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
