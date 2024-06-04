import 'package:fama/Views/Home/dashboard.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
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
                  text: 'Please enter your details below to continue'),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  CustomTextFormField(
                      labelText: "Phone Nmber / Email Address *",
                      hintText: 'Email or Phone number',
                      controller: email,
                      onChanged: (value) {}),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextFormField(
                      labelText: "Password *",
                      hintText: 'Enter your password',
                      controller: password,
                      suffix: Icon(Icons.visibility_off_sharp),
                      onChanged: (value) {}),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: CustomText(text: 'forgot password?')),
                  SizedBox(
                    height: 23.h,
                  ),
                  CustomButton(
                      text: 'Login',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      }),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: 'Dont have an account?'),
                      SizedBox(
                        width: 1.w,
                      ),
                      CustomText(
                        text: 'Create Account',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
