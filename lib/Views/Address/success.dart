import 'package:fama/Views/Auth/signin.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class AddressSuccess extends ConsumerStatefulWidget {
  const AddressSuccess({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuccessState();
}

class _SuccessState extends ConsumerState<AddressSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 35, 218, 41),
              size: 90,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomText(
              text: "You Did It!",
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomText(
              text: 'You are good to go, Thanks for completing our',
              fontSize: 9.sp,
            ),
            CustomText(
              text: 'Onboarding.',
              fontSize: 9.sp,
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 130),
              child: CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signin()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
