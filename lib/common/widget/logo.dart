import 'package:blog/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.size = 36});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => AppColors.logoGradient
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Qiyorie",
          style: GoogleFonts.leckerliOne(
            fontSize: size ?? 36,
          ),
        ),
      ),
    );
  }
}
