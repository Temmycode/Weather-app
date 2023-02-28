import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utils/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  double? size;
  FontWeight? weight;
  double? letterspacing;

  AppText({
    super.key,
    required this.text,
    this.size = 18,
    this.weight,
    this.letterspacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.russoOne(
        fontSize: size == 18 ? 18 : size,
        color: AppColors.whiteColor,
        fontWeight: weight,
        letterSpacing: letterspacing,
      ),
    );
  }
}
