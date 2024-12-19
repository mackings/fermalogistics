import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Widget? suffix;

  CustomTextFormField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.suffix, 
   List<TextInputFormatter>? inputFormatters
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          labelText,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 1.h),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 54, 50, 50)),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffix,
              hintStyle: GoogleFonts.inter(
                fontSize: 11.sp,
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        
      ],
    );
  }
}
