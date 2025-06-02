import 'package:getnamibia/Views/Auth/Api/Authservice.dart';
import 'package:getnamibia/Views/Auth/signin.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/formfields.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController tokenController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool isLoading = false;

  final ForgotPasswordService _forgotPasswordService = ForgotPasswordService();

  // Function to check password strength
  void _checkPasswordRequirements(String password) {
    setState(() {
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasLowerCase = password.contains(RegExp(r'[a-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  // Function to reset password
  Future<void> _resetPassword() async {
    if (hasUpperCase && hasLowerCase && hasNumber && hasSpecialChar) {
      setState(() {
        isLoading = true;
      });

      bool success = await _forgotPasswordService.resetPassword(
        tokenController.text.trim(),
        passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset successful!')),
        );

        // Navigate to Signin screen and remove previous screens from stack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Signin()),
          (route) => false, // Clears the stack
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to reset password. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password does not meet requirements!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Reset Password")),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              title: CustomText(
                text: 'Reset Password',
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              subtitle: CustomText(text: 'Enter the OTP sent to your email'),
            ),
            SizedBox(height: 2.h),

            // Token Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextFormField(
                labelText: "Token *",
                hintText: "Enter received token",
                controller: tokenController, 
                onChanged: (String ) {  },
              ),
            ),
            SizedBox(height: 2.h),

            // Password Field with Validation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    isPassword: true,
                    labelText: "New Password *",
                    hintText: "Enter new password",
                    controller: passwordController,
                    onChanged: _checkPasswordRequirements,
                  ),
                  SizedBox(height: 1.h),

                  // Password Validation Messages
                  _buildValidationText("Contains uppercase letter", hasUpperCase),
                  _buildValidationText("Contains lowercase letter", hasLowerCase),
                  _buildValidationText("Contains a number", hasNumber),
                  _buildValidationText("Contains a special character", hasSpecialChar),
                ],
              ),
            ),

            SizedBox(height: 23.h),

            // Reset Password Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: isLoading ? "Processing..." : "Reset password",
                onPressed: isLoading ? null : _resetPassword, // Disable button while loading
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show validation messages
  Widget _buildValidationText(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 16,
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(color: isValid ? Colors.green : Colors.red),
        ),
      ],
    );
  }
}