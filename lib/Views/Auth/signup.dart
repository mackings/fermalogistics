import 'package:getnamibia/Views/Auth/signin.dart';
import 'package:getnamibia/Views/Auth/verify.dart';
import 'package:getnamibia/Views/Home/dashboard.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/countrycode.dart';
import 'package:getnamibia/Views/widgets/formfields.dart';
import 'package:getnamibia/Views/widgets/passwordstregth.dart';
import 'package:getnamibia/Views/widgets/terms.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
  TextEditingController phonenumber = TextEditingController();

  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  String selectedCountry = ''; // Selected country name

  // Map of country codes and names
final Map<String, String> countryCodes = {
  '+234': 'Nigeria',
  '+260': 'Zambia',
  '+267': 'Botswana',
  '+255': 'Tanzania',
  '+264': 'Namibia',
  '+265': 'Malawi',
};


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



bool isLoading = false;



Future<void> signUp() async {
  setState(() {
    isLoading = true;
  });

  final Map<String, dynamic> requestData = {
    "fullName": fullname.text,
    "phoneNumber": "${countrycode.text}${phonenumber.text}", // Combine country code and phone number
    "email": email.text,
    "password": password.text,
    "country": selectedCountry, // Use mapped country name
  };

  // API URL
  final String url = "https://fama-logistics-ljza.onrender.com/api/v1/user/userSignUp";

  try {
    // Make the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );
    print(requestData);

    // Handle response
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print(responseData);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', responseData['user']['email']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup Successful: ${responseData['message']}')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Verification()),
      );
    } else {
      final responseData = jsonDecode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'])),
      );
      print(responseData);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
   // print(e);
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



Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    CustomText(text: "Phone Number"),
    SizedBox(height: 1.h),
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Row(
        children: [
          // Dropdown for selecting country code
Expanded(
  flex: 4, // Increased from 3 to 4
  child: DropdownButtonFormField<String>(
    isExpanded: true, 
    decoration: const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,  
    ),
    items: countryCodes.keys.map((code) {
      return DropdownMenuItem<String>(
        value: code,
        child: Text(
          code,
          overflow: TextOverflow.ellipsis, // Prevents overflow
          style: const TextStyle(fontSize: 14), // Optional: shrink slightly
        ),
      );
    }).toList(),
    onChanged: (value) {
      setState(() {
        countrycode.text = value!;
        selectedCountry = countryCodes[value]!;
      });
    },
    value: countrycode.text.isEmpty
        ? countryCodes.keys.first
        : countrycode.text,
    dropdownColor: Colors.white,
    icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
  ),
),

          SizedBox(width: 8.0),
          // Text field for phone number

          Expanded(
            flex: 13,
            child: TextFormField(
              controller: phonenumber, // Assign the phonenumber controller
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.phone,
              style: GoogleFonts.inter(),
            ),
          ),
                   
        ],
      ),
    ),
  ],
),


                  SizedBox(height: 3.h),
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

