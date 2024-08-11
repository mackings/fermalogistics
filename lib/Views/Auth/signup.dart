import 'package:fama/Views/Auth/verify.dart';
import 'package:fama/Views/Home/dashboard.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/countrycode.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/passwordstregth.dart';
import 'package:fama/Views/widgets/terms.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController countrycode = TextEditingController();

  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  void _checkPasswordRequirements(String password) {
    setState(() {
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasLowerCase = password.contains(RegExp(r'[a-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  List<String> Country = ['+234', '+233', '+245'];

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Create your Account",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: "Fill in the form below to get started",
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

                  CustomTextFormField(
                    labelText: "full name",
                    hintText: "Enter your full name",
                    controller: fullname,
                    onChanged: (p0) {},
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  
                  CustomTextFormField(
                    labelText: "email",
                    hintText: "Enter your email",
                    controller: fullname,
                    onChanged: (p0) {},
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextFormField(
                    labelText: "password",
                    hintText: "Enter your password",
                    controller: fullname,
                    onChanged: _checkPasswordRequirements,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  PasswordStrengthIndicator(
                    hasUpperCase: hasUpperCase,
                    hasLowerCase: hasLowerCase,
                    hasNumber: hasNumber,
                    hasSpecialChar: hasSpecialChar,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextFormField(
                    labelText: "confirm password",
                    hintText: "Confirm Password ",
                    controller: fullname,
                    onChanged: _checkPasswordRequirements,
                  ),
                  SizedBox(height: 2.h),

                  CountryCodeTextFormField(
                    labelText: 'Country code',
                    hintText: "8137159066",
                    controller: countrycode,
                    onChanged: (value) {},
                    countryCodes: ['+1', '+91', '+44'],
                    selectedCountryCode: '+91',
                  ),
                  
                  SizedBox(height: 2.h),
                  TermsAndConditionsWidget(
                      buttonColor: btncolor, onPressed: () {}),
                  SizedBox(height: 1.h),
                  CustomButton(
                      text: "Continue with Email",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Verification()));
                      }),
                  SizedBox(height: 1.h),
                  AlreadyHaveAccountWidget(
                    buttonColor: btncolor,
                    onLoginPressed: () {
                      
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
