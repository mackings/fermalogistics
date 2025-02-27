import 'package:fama/Views/Auth/attachimg.dart';
import 'package:fama/Views/Auth/signin.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;



class Verification extends ConsumerStatefulWidget {
  const Verification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerificationState();
}

class _VerificationState extends ConsumerState<Verification> {
  String? email;

  void _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    _loadEmail();
    super.initState();
  }

  void _validateOtp(String otp) async {
    final url =
        "https://fama-logistics.onrender.com/api/v1/user/verifyEmail/$otp";
    print(otp);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {

              ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Successfully Verified')),
      );
       
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Signin()),
        );
      } else {
        // Handle invalid OTP
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 17,
                right: 17,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                      height: 15.h,
                      child: VerificationInfoWidget(email: email ?? "Mail")),
                  SizedBox(
                    height: 2.h,
                  ),
                  VerificationWidget(onOtpEntered: _validateOtp),

                  SizedBox(
                    height: 5.h,
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
