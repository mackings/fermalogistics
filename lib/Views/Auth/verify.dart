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
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  Container(
                    height: 15.h,
                    child: VerificationInfoWidget(email: "Macs@gmail.com")),
                  VerificationWidget(),
                  SizedBox(height: 5.h,),
                  CustomButton(text: "Verify", onPressed: (){})
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
