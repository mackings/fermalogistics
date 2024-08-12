import 'package:fama/Views/Address/createaddress.dart';
import 'package:fama/Views/Send%20Product/steps/rateswidget.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/countrycode.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/packagedd.dart';
import 'package:fama/Views/widgets/terms.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StepForm3 extends StatefulWidget {
  final void Function(Map<String, dynamic> data) onComplete;

  const StepForm3({required this.onComplete, Key? key}) : super(key: key);

  @override
  State<StepForm3> createState() => _StepForm3State();
}

class _StepForm3State extends State<StepForm3> {
  TextEditingController itemName = TextEditingController();
  TextEditingController Weight = TextEditingController();
  TextEditingController pickupemail = TextEditingController();

  String selectedCategory = '';
  String selectedCategory2 = '';

  final List<String> categories = [
    'Select categories',
    'Electronics',
    'Fashion',
    'Home',
    'Books'
  ];

  final List<String> categories2 = [
    'Select shipping mehod',
    'Cargo',
    'Express'
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0];
    selectedCategory2 = categories2[0];
  }

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
              text: "Package details",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text: "Please enter the correct details ",
              fontSize: 8.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomTextFormField(
              labelText: "Item Name *",
              hintText: "Enter your full name",
              controller: itemName,
              onChanged: (p0) {},
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomTextFormField(
              labelText: "Weight of package *",
              hintText: "Enter Pickup Address",
              controller: Weight,
              //suffix: 'Kg',
              onChanged: (p0) {},
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomDropdownFormField(
              labelText: "Package Category *",
              // hintText: selectedCategory == null? "Select a Category":selectedCategory,
              hintText: "Select a Category",
              value: selectedCategory,
              items: [
                'Select categories',
                'Electronics',
                'Fashion',
                'Home',
                'Books'
              ],
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue ?? '';
                  print(selectedCategory);
                });
              },
            ),
            SizedBox(height: 2.h),
            CustomTextFormField(
              labelText: "No of packages *",
              hintText: "Enter Pickup Address",
              controller: Weight,
              onChanged: (p0) {},
            ),
            SizedBox(height: 2.h),
            CustomDropdownFormField(
              labelText: "Select Shipping method *",
              hintText: "Select a Category",
              value: selectedCategory2,
              items: [
                'Select shipping mehod',
                'Cargo',
                'Express',
              ],
              onChanged: (newValue) {
                setState(() {
                  selectedCategory2 = newValue ?? ''; 
                  print(selectedCategory2);

                  showRatesModal(
                         context,
                   pickupLocation: '800 Gwanzo, China',
                  destinationLocation: 'Lagos Nigeria',
                  cargoPrice: 'USD 20',
                  expressPrice: 'USD 60',
                  onRateSelected: (title, price) {
                  print('User selected $title with price $price');
               },
);


                });
              },
            ),
            SizedBox(height: 5.h),
            CustomButton(
                text: 'Continue',
                onPressed: () {
                  widget.onComplete({'step2Data': 'data from step 2'});
                })
          ],
        ),
      ),
    );
  }
}
