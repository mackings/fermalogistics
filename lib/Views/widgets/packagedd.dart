import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;
  final Widget? suffix;

  CustomDropdownFormField({
    required this.labelText,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.suffix,
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
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: DropdownButtonFormField<String>(
            value: value.isNotEmpty ? value : null,
            onChanged: onChanged,
            items: items.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(
                  category,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffix,
              hintStyle: GoogleFonts.inter(
                fontSize: 11.sp,
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
            dropdownColor: Colors.white,
            iconEnabledColor: Colors.black,
          ),
        ),
      ],
    );
  }
}