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
  TextEditingController length = TextEditingController();
  TextEditingController Width = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController pickupemail = TextEditingController();
  TextEditingController noofPackages = TextEditingController();

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
              hintText: "Enter your Item name",
              controller: itemName,
              onChanged: (p0) {},
            ),
            SizedBox(height: 2.h),

          TwoFieldsRow(controller1:Weight , controller2: length),

            SizedBox(
              height: 2.h,
            ),

          TwoFieldsRow2(controller1:Width , controller2: height),

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
              controller: noofPackages,
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
    widget.onComplete({
      'itemName': itemName.text,
      'weightOfPackage': int.tryParse(Weight.text) ?? 0, // Convert to integer
      'length':int.tryParse(length.text)?? 0,
      'width':int.tryParse(Width.text)?? 0,
      'height':int.tryParse(height.text)?? 0,
      'packageCategory': selectedCategory,
      'numberOfPackages': int.tryParse(noofPackages.text) ?? 0, // Example
      'shipmentMethod': selectedCategory2,
    });
  },
)

          ],
        ),
      ),
    );
  }
}


class TwoFieldsRow extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;

  TwoFieldsRow({
    required this.controller1,
    required this.controller2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // First CustomTextFormField
        Expanded(
          child: CustomTextFormField(
            labelText: 'Weight',
            hintText: 'Enter weight in KG',
            controller: controller1,
            onChanged: (value) {
              // Handle changes here
            },
          ),
        ),
        SizedBox(width: 4.w), // Add spacing between the two fields
        // Second CustomTextFormField
        Expanded(
          child: CustomTextFormField(
            labelText: 'Length',
            hintText: 'Enter Length',
            controller: controller2,
            onChanged: (value) {
              // Handle changes here
            },
          ),
        ),
      ],
    );
  }
}

class TwoFieldsRow2 extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;

  TwoFieldsRow2({
    required this.controller1,
    required this.controller2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // First CustomTextFormField
        Expanded(
          child: CustomTextFormField(
            labelText: 'Width',
            hintText: 'Enter Width',
            controller: controller1,
            onChanged: (value) {
              // Handle changes here
            },
          ),
        ),
        SizedBox(width: 4.w), // Add spacing between the two fields
        // Second CustomTextFormField
        Expanded(
          child: CustomTextFormField(
            labelText: 'Height',
            hintText: 'Enter Height',
            controller: controller2,
            onChanged: (value) {
              // Handle changes here
            },
          ),
        ),
      ],
    );
  }
}

