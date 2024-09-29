import 'dart:convert';

import 'package:fama/Views/Send%20Product/steps/step1.dart';
import 'package:fama/Views/Send%20Product/steps/step2.dart';
import 'package:fama/Views/Send%20Product/steps/step3.dart';
import 'package:fama/Views/Send%20Product/steps/step4.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class SendProduct extends ConsumerStatefulWidget {
  const SendProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SendProductState();
}

class _SendProductState extends ConsumerState<SendProduct> {
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

  List<bool> _stepsCompleted = [false, false, false, false];
  int _currentStep = 0;
  bool isLoading = false;

  final Map<String, dynamic> formData = {};

  Future<void> _makeApiCall() async {
    final url =
        "https://fama-logistics.onrender.com/api/v1/dropshipperShipment/createShipmentPayByWallet";

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    try {
      print("Send Datas >>> $formData");
      setState(() {
        // Show loading state
        isLoading = true;
      });

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(formData), // Send the collected formData
      );

      setState(() {
        // Disable loading state
        isLoading = false;
      });

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print("Shipment created successfully: $responseData");

        // Pass API response data to the modal
        _showShipmentSummary(context, responseData['shipment']);
      } else {
        // Handle failure
        print("Failed to create shipment: ${response.body}");
        // Optionally show error message
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error making API call: $e");
      // Optionally show error message
    }
  }

  void _completeStep(Map<String, dynamic> data) {
    setState(() {
      _stepsCompleted[_currentStep] = true;
      formData.addAll(data); // Collect the form data
      if (_currentStep < 3) {
        _currentStep++;
      } else {
        // Make API call once all steps are completed
         _makeApiCall();
       // _showShipmentSummary(context, formData);
      }
    });
  }

  @override
  void initState() {
    _retrieveUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Send Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return Container(
                  width: 70,
                  height: 3,
                  color: _stepsCompleted[index] ? Colors.red : Colors.grey,
                );
              }),
            ),
            Expanded(
              child: _getFormForStep(_currentStep),
            ),
            if (isLoading)
            LinearProgressIndicator(color: btncolor,),
          ],
        ),
      ),
    );
  }

  Widget _getFormForStep(int step) {
    switch (step) {
      case 0:
        return StepForm1(onComplete: _completeStep);
      case 1:
        return StepForm2(onComplete: _completeStep);
      case 2:
        return StepForm3(onComplete: _completeStep);
      case 3:
        return StepForm4(onComplete: _completeStep);
      default:
        return Container();
    }
  }

void _showShipmentSummary(BuildContext context, Map<String, dynamic> shipmentData) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {

      return DraggableScrollableSheet(
        expand: false,
        builder: (_, controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 20),

                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: GestureDetector(
                        onTap: (){Navigator.pop(context);},
                        child: Icon(Icons.close,color: Colors.white,),
                      ),
                    ),
                  ),
                  Text(
                    "Shipment Summary",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Here is a review of your shipment",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSummaryRow("Sender's Name", shipmentData['senderName']),
                  _buildSummaryRow("Phone Number", shipmentData['phoneNumber']),
                  _buildSummaryRow("Email", shipmentData['emailAddress']),
                  _buildSummaryRow("Pickup Address", shipmentData['pickupAddress']),
                  Divider(),
                  _buildSummaryRow("Receiver's Name", shipmentData['recieverName']),
                  _buildSummaryRow("Phone Number", shipmentData['recieverPhoneNumber']),
                  _buildSummaryRow("Email", shipmentData['recieverEmailAddress']),
                  _buildSummaryRow("Receiver's Address", shipmentData['recieverAddress']),
                  Divider(),
                  _buildSummaryRow("Shipping Fee", "\$${shipmentData['amount']}.00"), // Dynamic shipping fee
                  _buildSummaryRow("Payment Method", formData['paymentMethod']),
                  SizedBox(height: 5.h),

                  CustomButton(text: "Confirm Order", onPressed: () {
                    Navigator.pop(context);
                  })
                ],
              ),
            ),
          );
        },
      );
    },
  );
}


  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
