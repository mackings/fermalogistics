import 'dart:convert';

import 'package:getnamibia/Views/Auth/forgotpassword.dart';
import 'package:getnamibia/Views/Drivers/Home/driverhome.dart';
import 'package:getnamibia/Views/Home/dashboard.dart';
import 'package:getnamibia/Views/Home/home.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/formfields.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getnamibia/Views/widgets/verifysheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;


class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;




Future<void> _login() async {
  setState(() {
    isLoading = true;
  });

  final Map<String, dynamic> requestData = {
    "email": email.text,
    "password": password.text,
  };

  final String url =
      "https://fama-logistics-ljza.onrender.com/api/v1/user/userLogin";

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );

    final responseData = jsonDecode(response.body);
    print('API Response: $responseData'); // ✅ Console log

if (response.statusCode == 200) {
  final user = responseData['user'];
  final role = user?['roles'];

  if (user != null && role != null) {
    // Save user data to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(responseData));

    print('User role: $role');

    // Define roles that go to HomePage
    const homePageRoles = ['dropShipper', 'admin'];

    if (homePageRoles.contains(role)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DriverHomePage()),
      );
    }
  } else {
    final msg = responseData['message'] ?? 'Invalid response format.';
    if (msg.toLowerCase().contains("pending")) {
      VerifyAccountBottomSheet.show(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }
}


  } catch (e) {
    print('Error during login: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred. Please try again.')),
    );
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: CustomText(
                text: 'Login Now',
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              subtitle: CustomText(
                text: 'Please enter your details below to continue',
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: "Phone Number / Email Address *",
                    hintText: 'Email or Phone number',
                    controller: email,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 2.h),
                  CustomTextFormField(
                    isPassword: true,
                    labelText: "Password *",
                    hintText: 'Enter your password',
                    controller: password,
                    suffix: Icon(Icons.visibility_off_sharp),
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Forgotpassword(),
                          ),
                        );
                      },
                      child: CustomText(text: 'Forgot password?'),
                    ),
                  ),
                  SizedBox(height: 23.h),
                  isLoading
                      ? CircularProgressIndicator(color: btncolor)
                      : CustomButton(text: 'Login', onPressed: _login),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: 'Don\'t have an account?'),
                      SizedBox(width: 1.w),
                      CustomText(
                        text: 'Create Account',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
