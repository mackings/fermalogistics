import 'dart:convert';
import 'package:getnamibia/Views/Auth/Pin/Createpin.dart';
import 'package:getnamibia/Views/Stock/Widgets/Payments/recipt.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartPinInputModal extends StatefulWidget {
  late final String id;

  CartPinInputModal({required this.id});
  @override
  _CartPinInputModalState createState() => _CartPinInputModalState();
}

class _CartPinInputModalState extends State<CartPinInputModal> {
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

  final List<String> _pin = ['', '', '', ''];
  int _currentIndex = 0;

  void _handleKeyPress(String value) {
    setState(() {
      if (value == 'delete') {
        if (_currentIndex > 0) {
          _currentIndex--;
          _pin[_currentIndex] = '';
        }
      } else {
        if (_currentIndex < 4) {
          _pin[_currentIndex] = value;
          _currentIndex++;

          if (_currentIndex == 4) {
            _onPinComplete(widget.id);
          }
        }
      }
    });
  }

  void _onPinComplete(String id) async {
    String enteredPin = _pin.join('');
    print("Entered PIN: $enteredPin");

    // API URL
    final String url =
        "https://fama-logistics-ljza.onrender.com/api/v1/dropshipperShipment/createShipmentPayByWallet/$id";

    // Request body
    final Map<String, dynamic> requestBody = {"pin": enteredPin};

    try {
      print(id);
      // Make the API call
      final response = await http.post(
        Uri.parse(url),

        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $userToken',
        },

        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        // Successful response
        final responseData = jsonDecode(response.body);
        print("$responseData");
        print(response.statusCode);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Payment Successful!')));

        // Navigate to the success page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => SuccessDetailsPage(
                  senderName: responseData['shipment']['senderName'],
                  phoneNumber: responseData['shipment']['phoneNumber'],
                  email: responseData['shipment']['emailAddress'],
                  pickupAddress: responseData['shipment']['pickupAddress'],
                  receiverName: responseData['shipment']['receiverName'],
                  receiverPhoneNumber:
                      responseData['shipment']['receiverPhoneNumber'],
                  receiverEmail:
                      responseData['shipment']['receiverEmailAddress'],
                  receiverAddress: responseData['shipment']['receiverAddress'],
                  shippingFee:
                      (responseData['shipment']['amount'] as num).toDouble(),
                  status: responseData['shipment']['status'],
                  trackingNumber: responseData['shipment']['trackingNumber'],
                ),
          ),
        );
      } else {

        // print(response.body);
        final responseData = jsonDecode(response.body);
        String errorMessage = responseData['message'];
        // print("Error: $errorMessage");

        // ScaffoldMessenger.of(
        //   context,
        // ).showSnackBar(SnackBar(content: Text(errorMessage)));

        if (errorMessage == "PIN does not exist. Please create a new PIN.") {
          print("Yes a PIN Error");
          _showCreatePinErrorModal();
        }
      }
    } catch (e) {
      // Handle exceptions
      print("Exception: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }



  void _showCreatePinErrorModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
            text: "Create New Pin",
            fontWeight: FontWeight.w600,
          ),
          content: CustomText(
            text: "PIN does not exist. Please create a new PIN",
          ),
          actions: [
            // Cancel Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      text: "Cancel",
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),



        GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Close the modal
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CreatePin()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: "Create PIN",
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),


              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _retrieveUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          SizedBox(height: 16),
          _buildPinFields(),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: CustomText(text: "Forgot Payment PIN?", fontSize: 11),
          ),
          SizedBox(height: 20),
          _buildNumberPad(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 24),
        Expanded(
          child: Center(
            child: CustomText(
              text: "Enter Payment PIN",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildPinFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (index) {
        return Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _pin[index],
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        for (int i = 1; i <= 3; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int j = 1; j <= 3; j++)
                Expanded(child: _buildNumberButton('${3 * (i - 1) + j}')),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            Expanded(child: _buildNumberButton('0')),
            Expanded(child: _buildNumberButton('delete', isDelete: true)),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(String value, {bool isDelete = false}) {
    return GestureDetector(
      onTap: () => _handleKeyPress(value),
      child: Container(
        height: 70,
        margin: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child:
            isDelete
                ? Icon(Icons.backspace, size: 24)
                : Text(value, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
