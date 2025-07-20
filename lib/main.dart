import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartbecho/routes/app_pages.dart';
import 'package:smartbecho/routes/app_routes.dart';
import 'package:smartbecho/utils/page_not_found.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'SmartBecho',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      unknownRoute: GetPage(name:AppRoutes.notFound, page:() => PageNotFound(),),
      // home: HomeScreen(),
    );
  }
}
