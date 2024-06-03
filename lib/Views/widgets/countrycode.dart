import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CountryCodeTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final List<String> countryCodes;
  final String selectedCountryCode;

  CountryCodeTextFormField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.countryCodes,
    required this.selectedCountryCode,
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

        SizedBox(height: 8.0),

        Container(
          height: 7.h,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
DropdownButton<String>(
  value: selectedCountryCode,
  onChanged: (String? newValue) {},
  underline: null, // Remove underline
  items: countryCodes.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }).toList(),
),


             VerticalDivider(color: Colors.grey),

              Expanded(
                child: TextFormField(
                  controller: controller,
                  onChanged: onChanged,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none, // Remove input borders
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
