import 'package:blog/routes/app_pages.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/app_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.LOGIN,
      initialBinding: AppBinding(),
      navigatorKey: Get.key,
      theme: ThemeData(useMaterial3: false),
    );
  }
}
