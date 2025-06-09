import 'dart:convert';
import 'package:getnamibia/Views/Send%20Product/steps/step1.dart';
import 'package:getnamibia/Views/Send%20Product/steps/step2.dart';
import 'package:getnamibia/Views/Send%20Product/steps/step3.dart';
import 'package:getnamibia/Views/Send%20Product/steps/step4.dart';
import 'package:getnamibia/Views/Stock/Widgets/Payments/Pinwidgets.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
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
        "https://fama-logistics-ljza.onrender.com/api/v1/dropshipperShipment/calculationInvolvedShipment";

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    try {
      print("Send Datas >>> $formData");
      setState(() {
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
        final responseData = json.decode(response.body);
        print("Failed to create shipment: ${response.body}");

        // Show error message in Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${responseData['message']}"),
            backgroundColor: btncolor,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error making API call: $e");

      // Show generic error message in Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error making API call: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  void _completeStep(Map<String, dynamic> data) {
    setState(() {
      _stepsCompleted[_currentStep] = true;
      formData.addAll(data);
      if (_currentStep < 3) {
        _currentStep++;
      } else {
        _makeApiCall();
      }
    });
  }



  void _showPinInputModal(BuildContext context, String id) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: CartPinInputModal(id: id), 
      ),
    );
  }


  late List<Widget?> _stepForms;


@override
void initState() {
  super.initState();
  _retrieveUserData();

  _stepForms = [
    StepForm1(onComplete: _completeStep),
    StepForm2(onComplete: _completeStep),
    StepForm3(onComplete: _completeStep, previousData: formData),
    StepForm4(onComplete: _completeStep),
  ];
}


  @override
  Widget build(BuildContext context) {
    return PopScope(
  canPop: _currentStep == 0, // Allow system pop only on the first step
  onPopInvoked: (didPop) {
    if (!didPop && _currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  },
  child: Scaffold(
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
            LinearProgressIndicator(
              color: btncolor,
            ),
        ],
      ),
    ),
  ),
);


  }


Widget _getFormForStep(int step) => _stepForms[step]!;

  // Widget _getFormForStep(int step) {
  //   switch (step) {
  //     case 0:
  //       return StepForm1(onComplete: _completeStep);
  //     case 1:
  //       return StepForm2(onComplete: _completeStep);
  //     case 2:
  //       return StepForm3(
  //         onComplete: _completeStep,
  //         previousData: formData,
  //       );

  //     case 3:
  //       return StepForm4(onComplete: _completeStep);
  //     default:
  //       return Container();
  //   }
  // }


  void _showShipmentSummary(
      BuildContext context, Map<String, dynamic> shipmentData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
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
                    
                    _buildSummaryRow(
                        "Sender's Name", shipmentData['senderName']),
                    _buildSummaryRow(
                        "Phone Number", shipmentData['phoneNumber']),
                    _buildSummaryRow("Email", shipmentData['emailAddress']),
                    _buildSummaryRow(
                        "Pickup Address", shipmentData['pickupAddress']),
                    Divider(),
                    _buildSummaryRow(
                        "Receiver's Name", shipmentData['receiverName']),
                    _buildSummaryRow(
                        "Phone Number", shipmentData['receiverPhoneNumber']),
                    _buildSummaryRow(
                        "Email", shipmentData['receiverEmailAddress']),
                    _buildSummaryRow(
                        "Receiver's Address", shipmentData['receiverAddress']),
                    Divider(),
                    _buildSummaryRow(
                        "Shipping Fee", "\$${shipmentData['amount']}.00"),
                    _buildSummaryRow(
                        "Payment Method", formData['paymentMethod']),
                    SizedBox(height: 5.h),
                    CustomButton(
                      text: "Confirm Order",
                      onPressed: () {
                        _showPinInputModal(context,
                            shipmentData['_id']); 
                        print(shipmentData['_id']);
                      },
                    )
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
