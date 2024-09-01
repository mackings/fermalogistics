import 'package:fama/Views/Auth/signin.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  void _onSignUpButtonPressed() {
    _checkPasswordRequirements(password.text);

    if (hasUpperCase && hasLowerCase && hasNumber && hasSpecialChar) {
      signUp();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Password must include uppercase, lowercase, number, and special character.')),
      );
    }
  }

  List<String> Country = ['+234', '+233', '+245'];

  bool isLoading = false;

  Future<void> signUp() async {
    setState(() {
      isLoading = true;
    });

    final Map<String, dynamic> requestData = {
      "fullName": fullname.text,
      "phoneNumber": countrycode.text,
      "email": email.text,
      "password": password.text,
      // Optional
      "country": "Nigeria",
      "roles": "deliveryPersonnel",
      "address": "56, Hugh street, Yaba, Lagos"
    };

    // API URL
    final String url =
        "https://fama-logistics.onrender.com/api/v1/user/userSignUp";

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );
      print(requestData);

      // Check if the request was successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the API response
        final responseData = jsonDecode(response.body);
        print(responseData);

        // Save email to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', responseData['user']['email']);

        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Signup Successful: ${responseData['message']}')),
        );

       Navigator.push(context, MaterialPageRoute(builder: (context) => Verification()));
      } else {
        final responseData = jsonDecode(response.body);

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(responseData['message'])),
);


        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                    controller: email,
                    onChanged: (p0) {},
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextFormField(
                    labelText: "password",
                    hintText: "Enter your password",
                    controller: password,
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
                    controller: password,
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
                  isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                            color: btncolor,
                          ),
                      )
                      : CustomButton(
                          text: "Continue with Email",
                          onPressed: () {
                            _onSignUpButtonPressed();
                          }),
                  SizedBox(height: 1.h),
                  AlreadyHaveAccountWidget(
                    buttonColor: btncolor,
                    onLoginPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signin()));
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
