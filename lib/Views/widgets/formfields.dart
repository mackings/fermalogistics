import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Widget? suffix;
  final bool? isPassword;
  final List<TextInputFormatter>? inputFormatters; // Added back

  CustomTextFormField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.suffix,
    this.isPassword,
    this.inputFormatters, // Optional input formatters
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true; // Default state for password visibility

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
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
            controller: widget.controller,
            onChanged: widget.onChanged,
            obscureText: widget.isPassword == true ? _isObscured : false,
            inputFormatters: widget.inputFormatters, // Apply formatters if provided
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: 11.sp,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              suffixIcon: widget.isPassword == true
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : widget.suffix, // Show provided suffix if not a password field
            ),
          ),
        ),
      ],
    );
  }
}


