import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
 // Adjust the import according to your file structure

class PasswordStrengthIndicator extends StatelessWidget {
  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasNumber;
  final bool hasSpecialChar;

  PasswordStrengthIndicator({
    required this.hasUpperCase,
    required this.hasLowerCase,
    required this.hasNumber,
    required this.hasSpecialChar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIndicator(context, hasUpperCase, '', Colors.red),
            _buildIndicator(context, hasLowerCase, '', Colors.blue),
            _buildIndicator(context, hasNumber, '', Colors.orange),
            _buildIndicator(context, hasSpecialChar, '', Colors.purple),

            //  _buildIndicator(context, hasUpperCase, 'A', Colors.red),
            // _buildIndicator(context, hasLowerCase, 'a', Colors.blue),
            // _buildIndicator(context, hasNumber, '1', Colors.orange),
            // _buildIndicator(context, hasSpecialChar, '@', Colors.purple),
          ],
        ),
        SizedBox(height: 2.h),
        _buildRequirementCheck(context, hasUpperCase, "Contains an uppercase letter"),
        _buildRequirementCheck(context, hasLowerCase, "Contains a lowercase letter"),
        _buildRequirementCheck(context, hasNumber, "Contains a number"),
        _buildRequirementCheck(context, hasSpecialChar, "Contains a special character"),
      ],
    );
  }

  Widget _buildIndicator(BuildContext context, bool metRequirement, String label, Color color) {
    return Container(
      width: 18.w,
      height: 2.w,  // Adjusted height for better visibility
      decoration: BoxDecoration(
        color: metRequirement ? color : Colors.grey,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: Text( 
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementCheck(BuildContext context, bool metRequirement, String requirement) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: CheckRadio(isChecked: metRequirement),
        ),
        SizedBox(width: 2.w),
        Text(
          requirement,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: metRequirement ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}



class CheckRadio extends StatelessWidget {
  final bool isChecked;

  CheckRadio({required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isChecked ? Colors.green : Colors.grey),
        color: isChecked ? Colors.green : Colors.transparent,
      ),
      child: Center(
        child: isChecked
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 16.0,
              )
            : null,
      ),
    );
  }
}