import 'package:fama/Views/Auth/attachimg.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Verification extends ConsumerStatefulWidget {
  const Verification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerificationState();
}

class _VerificationState extends ConsumerState<Verification> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 17, right: 17,),
              child: Column(
                children: [
                  SizedBox(height: 7.h,),
                  Container(
                      height: 15.h,
                      child: VerificationInfoWidget(email: "Macs@gmail.com")),
                      SizedBox(height: 2.h,),
                  VerificationWidget(),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomButton(
                      text: "Verify",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttachImg()));
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
