import 'package:fama/Views/Address/createaddress.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/countrycode.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/packagedd.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';





class DStepForm2 extends StatefulWidget {
  final void Function(Map<String, dynamic> data) onComplete;

  const DStepForm2({required this.onComplete, Key? key}) : super(key: key);

  @override
  State<DStepForm2> createState() => _DStepForm2State();
}

class _DStepForm2State extends State<DStepForm2> {

  TextEditingController licsense = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            CustomText(
              text: "Private & Licsensing details",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text:
                  "Your Details are not shared to third party",
              fontSize: 7.sp,
              fontWeight: FontWeight.w400,
            ),

            SizedBox(height: 2.h),

            CustomTextFormField(
              labelText: "Driver Licsense / JTB Number *",
              hintText: "Enter Details on your document",
              controller: licsense,
              onChanged: (p0) {},
            ),

            SizedBox(
              height: 45.h,
            ),
            CustomButton(
              text: 'Continue',
              onPressed: () {
                widget.onComplete({
                  // 'senderName': senderName.text,
                  // 'phoneNumber': senderPhone.text,
                  // 'pickupAddress': pickupAddress.text,
                  // 'emailAddress': pickupEmail.text,
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
