import 'package:country_picker/country_picker.dart';
import 'package:getnamibia/Views/Auth/signin.dart';
import 'package:getnamibia/Views/Auth/verify.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/formfields.dart';
import 'package:getnamibia/Views/widgets/newcountrycode.dart';
import 'package:getnamibia/Views/widgets/passwordstregth.dart';
import 'package:getnamibia/Views/widgets/terms.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
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
            'Password must include uppercase, lowercase, number, and special character.',
          ),
        ),
      );
    }
  }

  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  TextEditingController phonenumber = TextEditingController();

  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;


  String selectedCountry = 'Nigeria';
  String selectedCode = '+234';

  bool isLoading = false;

  Future<void> signUp() async {
    setState(() {
      isLoading = true;
    });

    final Map<String, dynamic> requestData = {
      "fullName": fullname.text,
      "phoneNumber": "${countrycode.text}${phonenumber.text}",
      "email": email.text,
      "password": password.text,
      "country": selectedCountry,
    };

    final String url =
        "https://fama-logistics-ljza.onrender.com/api/v1/user/userSignUp";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );
      print('Sending: $requestData');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Success: $responseData');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', responseData['user']['email']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup Successful: ${responseData['message']}'),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Verification()),
        );
      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Signup failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
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
                  GestureDetector(
                    onTap: () {
showCountryPicker(
  context: context,
  showPhoneCode: true,
  onSelect: (Country country) {
    final dialCode = '+${country.phoneCode}';
    final countryName = country.name; 
    
    debugPrint(
      'Selected: $countryName ($dialCode)',
    );

    print('Phone Code: ${country.phoneCode}');
    print('Country Name: ${country.name}');
    print('Country ISO Code: ${country.nameLocalized}');
  },
);
                    },
                    child: CustomText(
                      text: "Create your Account",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CustomText(
                    text: "Fill in the form below to get started",
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 2.h),

                  CustomTextFormField(
                    labelText: "Full Name",
                    hintText: "Enter your full name",
                    controller: fullname,
                    onChanged: (p0) {},
                  ),

                  SizedBox(height: 2.h),

                  CustomTextFormField(
                    labelText: "Email",
                    hintText: "Enter your email",
                    controller: email,
                    onChanged: (p0) {},
                  ),


                  SizedBox(height: 2.h),


Newcountrycode(
  labelText: 'Phone Number *',
  hintText: '8137159066',
  controller: phonenumber,
  selectedCountryCode: selectedCode,
  onCountryCodeChanged: (code) {
    setState(() {
      selectedCode = code;
      countrycode.text = code;
    });
    print("Code: $code");
  },
  onCountryNameChanged: (name) {
    setState(() {
      selectedCountry = name;
    });
    print("Country Name: $name");
  },
  onChanged: (value) {
  },
),


                  SizedBox(height: 2.h),

                  CustomTextFormField(
                    isPassword: true,
                    labelText: "Password",
                    hintText: "Enter your password",
                    controller: password,
                    onChanged: _checkPasswordRequirements,
                  ),

                  SizedBox(height: 2.h),

                  PasswordStrengthIndicator(
                    hasUpperCase: hasUpperCase,
                    hasLowerCase: hasLowerCase,
                    hasNumber: hasNumber,
                    hasSpecialChar: hasSpecialChar,
                  ),
                  
                  SizedBox(height: 2.h),

                  isLoading
                      ? Center(
                        child: CircularProgressIndicator(color: btncolor),
                      )
                      : CustomButton(
                        text: "Continue with Email",
                        onPressed: _onSignUpButtonPressed,
                      ),
                  SizedBox(height: 1.h),
                  AlreadyHaveAccountWidget(
                    buttonColor: btncolor,
                    onLoginPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signin()),
                      );
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
