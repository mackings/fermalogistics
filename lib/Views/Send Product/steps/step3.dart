import 'dart:convert';

import 'package:fama/Views/Address/createaddress.dart';
import 'package:fama/Views/Send%20Product/Api/shipmentclass.dart';
import 'package:fama/Views/Send%20Product/steps/rateswidget.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/countrycode.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/packagedd.dart';
import 'package:fama/Views/widgets/terms.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class StepForm3 extends StatefulWidget {
  final Function(Map<String, dynamic>) onComplete;
  final Map<String, dynamic> previousData;

  const StepForm3({
    required this.onComplete, // Initialize the callback
    required this.previousData,
    Key? key,
  }) : super(key: key);

  @override
  State<StepForm3> createState() => _StepForm3State();
}

class _StepForm3State extends State<StepForm3> {
  dynamic userToken;

  Future<void> _retrieveUserData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);

      String? token = userData['token'];
      Map<String, dynamic> user = userData['user'];

      String? fullName = user['fullName'];
      String? email = user['email'];

      setState(() {
        userToken = userData['token'];
        print(userToken);
      });
    }
  }

  Future<Map<String, dynamic>?> calculateShipmentCost(
      Map<String, dynamic> shipmentData) async {
    final url = Uri.parse(
        'https://fama-logistics.onrender.com/api/v1/dropshipperShipment/calculateShipmentCost');

    try {
      print(shipmentData);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken'
        },
        body: jsonEncode(shipmentData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData; // Contains express, cargo, and regular rates
      } else {
        print(
            'Failed to calculate shipment cost. Status code: ${response.statusCode}');
        print('${response.body}');
      }
    } catch (e) {
      print('Error occurred while calculating shipment cost: $e');
    }

    return null;
  }

  TextEditingController itemName = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController noofPackages = TextEditingController();

  String selectedCategory = '';
  String selectedCategory2 = '';

  final List<String> categories = [
    'Select categories',
    'Electronics',
    'Fashion',
    'Home',
    'Books',
  ];

  final List<String> categories2 = [
    'Select shipping method',
    'Cargo',
    'Express',
  ];

  @override
  void initState() {
    super.initState();
    _retrieveUserData();
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
            SizedBox(height: 5.h),
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
            SizedBox(height: 5.h),
            CustomTextFormField(
              labelText: "Item Name *",
              hintText: "Enter your Item name",
              controller: itemName,
              onChanged: (p0) {},
            ),
            SizedBox(height: 2.h),
            TwoFieldsRow(controller1: weight, controller2: length),
            SizedBox(height: 2.h),
            TwoFieldsRow2(controller1: width, controller2: height),
            SizedBox(height: 2.h),

            CustomDropdownFormField(
              labelText: "Package Category *",
              hintText: "Select a Category",
              value: selectedCategory,
              items: categories,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue ?? '';
                });
              },
            ),
            SizedBox(height: 2.h),

            CustomTextFormField(
              labelText: "No of packages *",
              hintText: "Enter No of Packages",
              controller: noofPackages,
              onChanged: (p0) {},
            ),
            
            SizedBox(height: 2.h),

            CustomDropdownFormField(
              labelText: "Select Shipping method *",
              hintText: "Select a Category",
              value: selectedCategory2,
              items: categories2,
              onChanged: (newValue) async {
                setState(() {
                  selectedCategory2 = newValue ?? '';
                });

                // Make sure you have access to data from Step 1 and Step 2
                // Map<String, dynamic> dataToSend = {
                // // 'recieverAddress': widget.recieverAddress, // from Step 2
                //  // 'pickupAddress': widget.pickupAddress, // from Step 1
                //   'weightOfPackage': int.tryParse(weight.text) ?? 0,
                //   'numberOfPackages': int.tryParse(noofPackages.text) ?? 0,
                //   'height': int.tryParse(height.text) ?? 0,
                //   'width': int.tryParse(width.text) ?? 0,
                //   'length': double.tryParse(length.text) ?? 0.0,
                // };

                Map<String, dynamic> dataToSend = {
                  'recieverAddress': widget.previousData['recieverAddress'],
                  'pickupAddress': widget.previousData['pickupAddress'],
                  'weightOfPackage': int.tryParse(weight.text) ?? 0,
                  'numberOfPackages': int.tryParse(noofPackages.text) ?? 0,
                  'height': int.tryParse(height.text) ?? 0,
                  'width': int.tryParse(width.text) ?? 0,
                  'length': double.tryParse(length.text) ?? 0.0,
                };

try {
  // Send the API request
  final response = await calculateShipmentCost(dataToSend);

  if (response != null) {
    // Show the rates modal with the new showModalBottomSheet
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 70.h,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Rates',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.close_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Divider(color: Colors.grey),
                    SizedBox(height: 3.h),

                    // Cargo Rate Section
                    Container(
                      height: 10.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: btngrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFFFEFF0),
                          child: SvgPicture.asset('assets/ship.svg'),
                        ),
                        title: CustomText(
                          text: 'Cargo',
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle: CustomText(
                          text: '3-5 days',
                          color: const Color.fromARGB(255, 226, 217, 217),
                        ),
                        trailing: CustomText(
                          text: 'USD ${response['cargo'].toString()}', // Cargo price
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Express Rate Section
                    Container(
                      height: 10.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: btngrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFFFEFF0),
                          child: SvgPicture.asset('assets/plane.svg'),
                        ),
                        title: CustomText(
                          text: 'Express',
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle: CustomText(
                          text: '1-2 days',
                          color: const Color.fromARGB(255, 226, 217, 217),
                        ),
                        trailing: CustomText(
                          text: 'USD ${response['express'].toString()}', // Express price
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} catch (error) {
  print("Error calculating shipment cost: $error");
  // Handle error scenario
}

              },
            ),
            SizedBox(height: 5.h),
            CustomButton(
              text: 'Continue',
              onPressed: () {
                widget.onComplete({
                  'itemName': itemName.text,
                  'weightOfPackage':
                      int.tryParse(weight.text) ?? 0, // Convert to integer
                  'length': int.tryParse(length.text) ?? 0,
                  'width': int.tryParse(width.text) ?? 0,
                  'height': int.tryParse(height.text) ?? 0,
                  'packageCategory': selectedCategory,
                  'numberOfPackages':
                      int.tryParse(noofPackages.text) ?? 0, // Example
                  'shipmentMethod': selectedCategory2,
                });
              },
            ),
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
