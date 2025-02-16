import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/delivery.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



void _showConfirmPickupModal(BuildContext context, SendOrder upcomingOrder) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Confirm Pickup",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Are you sure you want to confirm this pickup?",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Close modal
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text("No"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close modal
                    _confirmPickup(context, upcomingOrder);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Yes"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _confirmPickup(BuildContext context, SendOrder upcomingOrder) async {
  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );

  String? token = await _getAuthToken();
  if (token == null) {
    Navigator.pop(context); // Close loading dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Authentication error. Please log in again."),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  String orderId = upcomingOrder.id ?? ""; // Ensure order ID exists
  String apiUrl = "https://fama-logistics.onrender.com/api/v1/delivery/deliveryArrived/$orderId";

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    Navigator.pop(context); // Close loading dialog

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pickup confirmed successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to Pickupdelivery page after success
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Pickupdelivery(
            upcomingOrder: upcomingOrder,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to confirm pickup: ${response.body}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    Navigator.pop(context); // Close loading dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("An error occurred: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<String?> _getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('userData');
  if (userDataString != null) {
    Map<String, dynamic> userData = jsonDecode(userDataString);
    return userData['token'];
  }
  return null;
}
