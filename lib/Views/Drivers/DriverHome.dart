import 'dart:convert';
import 'package:getnamibia/Views/Drivers/Steps/Dstep1.dart';
import 'package:getnamibia/Views/Drivers/Steps/Dstep2.dart';
import 'package:getnamibia/Views/Drivers/Steps/Dstep3.dart';
import 'package:getnamibia/Views/Drivers/Steps/Dstep4.dart';
import 'package:getnamibia/Views/Drivers/widgets/facialphoto.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class DriverHome extends ConsumerStatefulWidget {
  const DriverHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DriverHomeState();
}

class _DriverHomeState extends ConsumerState<DriverHome> {

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
        isLoading = false;
      });

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print("Shipment created successfully: $responseData");
        //  _showShipmentSummary(context, responseData['shipment']);
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
    formData.addAll(data); // Merge the new data with the existing formData
    if (_currentStep < 3) {
      _currentStep++;
    } else {
  //    _makeApiCall();
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
        title: CustomText(text: "Registration"),
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
    );
  }

Widget _getFormForStep(int step) {
  switch (step) {
    case 0:
      return DStepForm1(onComplete: _completeStep);
    case 1:
      return DStepForm2(onComplete: _completeStep);
    case 2:
      return DStepForm3(
        onComplete: _completeStep,
      );
    case 3:
      return FacialVerificationWidget(
        formData: formData, // Pass the collected formData here
        onComplete: _completeStep,
      );
    default:
      return Container();
  }
}

}
 