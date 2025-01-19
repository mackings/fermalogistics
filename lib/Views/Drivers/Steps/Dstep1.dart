import 'package:fama/Views/Address/createaddress.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/countrycode.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/packagedd.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';




class DStepForm1 extends StatefulWidget {
  final void Function(Map<String, dynamic> data) onComplete;

  const DStepForm1({required this.onComplete, Key? key}) : super(key: key);

  @override
  State<DStepForm1> createState() => _DStepForm1State();
}

class _DStepForm1State extends State<DStepForm1> {
  TextEditingController PlateNumber = TextEditingController();

  String selectedCategory = '';
  String selectedCategory2 = '';

  String selectedLiscense = '';
  String selectedYear = '';
  String selectedColor = '';

  final List<String> categories = [
    'Male',
    'Female',
  ];

  final List<String> Licsenses = [
    'Class A',
    'Class B',
    'Class C',
    'Class D',
    'Class E',
    'Class F',
    'Class G',
  ];

    final List<String> years = [
    '2025',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
  ];

    final List<String> colors = [
    'White',
    'Black',
    'Grey',
    'Yellow',
    'Blue',
    'Others',
  ];

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
              text: "Personal Information",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text:
                  "Only your first name is visible to clients during delivery",
              fontSize: 7.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomDropdownFormField(
              labelText: "Gender Type *",
              hintText: "Select your Gender",
              value: selectedCategory,
              items: categories,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue ?? '';
                });
              },
            ),
            SizedBox(height: 2.h),
            CustomDropdownFormField(
              labelText: "Licsense Type *",
              hintText: "Select your Gender",
              value: selectedLiscense,
              items: Licsenses,
              onChanged: (newValue) {
                setState(() {
                  selectedLiscense = newValue ?? '';
                });
              },
            ),

            SizedBox(height: 2.h),

            CustomDropdownFormField(
              labelText: "Vehicle Year *",
              hintText: "Select your Vehicle year",
              value: selectedYear,
              items: years,
              onChanged: (newValue) {
                setState(() {
                  selectedYear = newValue ?? '';
                });
              },
            ),

           SizedBox(height: 2.h),
            CustomDropdownFormField(
              labelText: "Vehicle Colour *",
              hintText: "Select your Vehicle colour",
              value: selectedColor,
              items: colors,
              onChanged: (newValue) {
                setState(() {
                  selectedColor = newValue ?? '';
                });
              },
            ),

            SizedBox(height: 2.h),

            CustomTextFormField(
              labelText: "Plate Number *",
              hintText: "Enter Vehicle Plate Number",
              controller: PlateNumber,
              onChanged: (p0) {},
            ),

            SizedBox(
              height: 5.h,
            ),


CustomButton(
  text: 'Continue',
  onPressed: () {
    widget.onComplete({
      'gender': selectedCategory,
      'licenseType': selectedLiscense,
      'vehicleYear': selectedYear,
      'vehicleColor': selectedColor,
      'plateNumber': PlateNumber.text,
    });
  },
)

          ],
        ),
      ),
    );
  }
}
