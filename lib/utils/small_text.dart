import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utils/app_colors.dart';

class SmallText extends StatelessWidget {
  final String text;
  double? size;
  FontWeight? weight;
  Color? color;

  SmallText({
    super.key,
    required this.text,
    this.size = 14,
    this.weight,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.chakraPetch(
        fontSize: size == 14 ? 14 : size,
        color: color == Colors.black
            ? AppColors.whiteColor.withOpacity(0.5)
            : color,
        fontWeight: weight,
      ),
    );
  }
}
