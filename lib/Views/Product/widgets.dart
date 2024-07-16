import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ImageWithText extends StatelessWidget {
  final String? svgPath;
  final String title;
  final String bodyText1;
  final String bodyText2;

  const ImageWithText({
    this.svgPath,
    required this.title,
    required this.bodyText1,
    required this.bodyText2,
  });
 
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    
        SvgPicture.asset(
          'assets/request.svg',
          width: 300, // Adjust width as needed
          height: 300, // Adjust height as needed
        ),
        SizedBox(height: 10), 
        // Space between image and title
        CustomText(
          text:title,
          fontWeight: FontWeight.bold,
            fontSize: 18,
        ),

        SizedBox(height: 5), // Space between title and first body text
        CustomText(
          text:bodyText1,
            fontSize: 8.sp,
        ),
        SizedBox(height: 5), // Space between first and second body text
        CustomText(
          text:bodyText2,
            fontSize: 8.sp,
        ),
      ],
    );
  }
}
