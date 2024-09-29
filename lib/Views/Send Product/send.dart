import 'dart:convert';

import 'package:fama/Views/Send%20Product/steps/step1.dart';
import 'package:fama/Views/Send%20Product/steps/step2.dart';
import 'package:fama/Views/Send%20Product/steps/step3.dart';
import 'package:fama/Views/Send%20Product/steps/step4.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  final Map<String, dynamic> formData = {};

  Future<void> _makeApiCall() async {
    final url =
        "https://fama-logistics.onrender.com/api/v1/dropshipperShipment/createShipmentPayByWallet";

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'};

    try {
      print("Send Datas >>> $formData");
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(formData), // Send the collected formData
      );

      if (response.statusCode == 200) {
        // Handle success
        print("Shipment created successfully: ${response.body}");
      } else {
        // Handle failure
        print("Failed to create shipment: ${response.body}");
      }
    } catch (e) {
      print("Error making API call: $e");
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
}
