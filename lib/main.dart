import 'package:blog/core/themes/color.dart';
import 'package:blog/firebase_options.dart';
import 'package:blog/routes/app_pages.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'bindings/app_binding.dart';
import 'service/database/local_database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..indicatorSize = 50.0
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..indicatorColor = AppColors.blueGradient
    ..textColor = Colors.transparent
    ..maskColor = Colors.transparent
    ..boxShadow = [
      const BoxShadow(color: Colors.transparent)
    ]
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager.instance;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.SPLASH,
      initialBinding: AppBinding(),
      navigatorKey: Get.key,
      theme: ThemeData(useMaterial3: false),
      builder: EasyLoading.init(),
    );
  }
}
