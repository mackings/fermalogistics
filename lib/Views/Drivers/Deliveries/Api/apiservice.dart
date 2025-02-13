import 'dart:convert';
import 'package:fama/Views/Drivers/Deliveries/Model/ordermodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';





class DeliveryService {
  
  final String baseUrl = 'https://fama-logistics.onrender.com/api/v1/delivery/getAllSendOrders';

  // Method to retrieve auth token from SharedPreferences
  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token']; // Returning the token
    }
    return null; // If no token found, return null
  }

  // Method to fetch deliveries from the API based on status
  Future<List<SendOrder>> fetchDeliveries(String status) async {
    String? token = await _getAuthToken(); // Get the token

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token', // Pass token as Bearer Authorization header
      },
    );

    if (response.statusCode == 200) {
      // Decode response and map to SendOrder model
      var jsonResponse = json.decode(response.body);
      List deliveries = jsonResponse['data'];
      List<SendOrder> sendOrders = deliveries
          .where((delivery) => delivery['status'] == status) // Filter by status
          .map((delivery) => SendOrder.fromJson(delivery))
          .toList();
      return sendOrders; // Return the filtered list
    } else {
      throw Exception('Failed to load deliveries');
    }
  }
}
