import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int maxLines;

  ProductText({
    required this.text,
    this.fontSize = 25.0,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.maxLines = 1,
  });

  // Helper function to limit text to a specific pattern
  String getTruncatedText(String text, {int maxWords = 2}) {
    final words = text.split(" ");
    if (words.length <= maxWords) return text;
    return words.take(maxWords).join(" ") + "..";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getTruncatedText(text),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
