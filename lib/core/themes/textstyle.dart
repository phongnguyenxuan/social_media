import 'package:blog/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle robotoregular = GoogleFonts.roboto(
    fontWeight: FontWeight.normal,
  );

  static TextStyle linkStyle = GoogleFonts.roboto(
      fontWeight: FontWeight.normal,
      textStyle: const TextStyle(color: AppColors.linkColor));
}
