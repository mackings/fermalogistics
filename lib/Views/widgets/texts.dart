import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  CustomText({
    required this.text,
    this.fontSize = 12.0, // Default font size if not specified
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: fontSize.sp, 
        fontWeight: fontWeight,
        color: color,
        textStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
        )
      ),
    );
  }
}
