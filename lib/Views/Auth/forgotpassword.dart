import 'package:getnamibia/Views/Auth/Api/Authservice.dart';
import 'package:getnamibia/Views/Auth/resetpassword.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/formfields.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';





class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailController = TextEditingController();
  final ForgotPasswordService _forgotPasswordService = ForgotPasswordService();
  bool isLoading = false;

  void resetPassword() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool success =
        await _forgotPasswordService.sendResetLink(emailController.text);

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset link sent to your email.")),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResetPassword()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send reset link. Try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Password Reset"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: CustomText(
                text: 'Forgot Password',
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              subtitle: CustomText(text: 'Enter your email to receive an OTP'),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextFormField(
                labelText: "Email Address *",
                hintText: "Enter registered email",
                controller: emailController,
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: 43.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Colors.red,
                    )
                  : CustomButton(text: "Reset", onPressed: resetPassword),
            ),
          ],
        ),
      ),
    );
  }
}
