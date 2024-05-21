import 'package:blog/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CutomTheme {
  static final lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      brightness: Brightness.light,
      useMaterial3: false,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>(
            (states) => AppColors.primaryColor),
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ));
}
