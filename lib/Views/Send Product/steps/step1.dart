import 'package:fama/Views/Address/createaddress.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/countrycode.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';




class StepForm1 extends StatefulWidget {
  
  final void Function(Map<String, dynamic> data) onComplete;

  const StepForm1({required this.onComplete, Key? key}) : super(key: key);

  @override
  State<StepForm1> createState() => _StepForm1State();
}

class _StepForm1State extends State<StepForm1> {

  TextEditingController senderName = TextEditingController();
  TextEditingController senderPhone = TextEditingController();
  TextEditingController pickupAddress = TextEditingController();
  TextEditingController pickupEmail = TextEditingController();

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
              text: "Pick up details",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
      
            CustomText(
              text: "Please enter the correct details ",
              fontSize: 8.sp,
              fontWeight: FontWeight.w400,
            ),
      
            SizedBox(height: 5.h,),
      
            CustomTextFormField(
              labelText: "Sender's Name *",
              hintText: "Enter your full name",
              controller: senderName,
              onChanged: (p0) {},
            ),
      
            SizedBox(height: 2.h,),
      
               CountryCodeTextFormField(
                      labelText: 'Phone Number *',
                      hintText: "8137159066",
                      controller: senderPhone,
                      onChanged: (value) {},
                      countryCodes: ['+1', '+91', '+234'],
                      selectedCountryCode: '+234',
                    ),
      
                    SizedBox(height: 2.h,),
      
             CustomTextFormField(
              labelText: "Pickup Address *",
              hintText: "Enter Pickup Address",
              controller: pickupAddress,
              onChanged: (p0) {},
            ),
      
          SizedBox(height: 2.h,),
      
             CustomTextFormField(
              labelText: "Email Address *",
              hintText: "Enter Email",
              controller: pickupEmail,
              onChanged: (p0) {},
            ),
      
                SizedBox(height: 2.h),
      
                TextSwitchRow(
                    label: 'Save details?',
                    initialSwitchValue: true,
                    onSwitchChanged: (value) {}
                    ),


                    SizedBox(height: 2.h),

CustomButton(
  text: 'Continue',
  onPressed: () {
    widget.onComplete({
      'senderName': senderName.text,
      'phoneNumber': senderPhone.text,
      'pickupAddress': pickupAddress.text,
      'emailAddress': pickupEmail.text,
    });
  },
)


          ],
        ),
      ),
    );
  }
}