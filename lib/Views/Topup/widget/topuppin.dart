
import 'dart:convert';

import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;




class TopUpPin extends StatefulWidget {
  final Function(String) onAmountUpdated;

  TopUpPin({required this.onAmountUpdated});

  @override
  _TopUpPinState createState() => _TopUpPinState();
}

class _TopUpPinState extends State<TopUpPin> {
  String _formattedAmount = ''; // Displayed to the user (e.g., "1,000")
  String _unformattedAmount = ''; // Sent to API (e.g., "1000")

  /// Retrieves user token from SharedPreferences
  Future<String?> retrieveUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token'];
    }
    return null;
  }

  /// Formats amount with commas for display
  String _formatAmount(String amount) {
    if (amount.isEmpty) return ''; // Return empty if no input
    final number = int.tryParse(amount);
    if (number == null) return amount; // If parsing fails, return original
    return NumberFormat('#,###').format(number); // Format with commas
  }

  /// Calls the API to fund wallet
  Future<void> fundWallet() async {
    String? token = await retrieveUserToken();
    if (token == null) {
      print("Error: User token not found");
      return;
    }

    final String url = "https://fama-logistics.onrender.com/api/v1/wallet/fundWallet";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'amount': _unformattedAmount}),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        String? authorizationUrl = responseData['authorizationUrl'];

        if (authorizationUrl != null) {
          _openWebView(authorizationUrl);
        } else {
          print("Error: Authorization URL not received");
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  /// Opens the WebView for payment
  void _openWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    );
  }

  /// Handles keypad input
  void _handleKeyPress(String value) {
    setState(() {
      if (value == 'delete' && _unformattedAmount.isNotEmpty) {
        _unformattedAmount = _unformattedAmount.substring(0, _unformattedAmount.length - 1);
      } else if (value != 'delete' && value != 'continue') {
        _unformattedAmount += value;
      }

      _formattedAmount = _formatAmount(_unformattedAmount); // Update formatted display
    });
  }

  /// Handles continue button click (triggers API call)
  void _handleContinue() {
    if (_unformattedAmount.isNotEmpty) {
      widget.onAmountUpdated(_unformattedAmount);
      fundWallet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAmountDisplay(),
          SizedBox(height: 16),
          _buildContinueButton(),
          SizedBox(height: 16),
          _buildNumberPad(),
        ],
      ),
    );
  }

  Widget _buildAmountDisplay() {
    return Column(
      children: [
        CustomText(text: "N ${_formattedAmount.isEmpty ? '0' : _formattedAmount}", fontSize: 24, fontWeight: FontWeight.w600),
        SizedBox(height: 8),
        CustomText(text: "Amount to Top Up", fontSize: 12, fontWeight: FontWeight.w400),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _handleContinue,
        child: CustomButton(text: "Continue", onPressed: _handleContinue),
      ),
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
        child: isDelete ? Icon(Icons.backspace, size: 24) : Text(value, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// WebView Screen for Payment
class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Complete TopUp")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)), // Use WebUri instead of Uri
      ),
    );
  }
}
