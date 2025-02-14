import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/ordermodel.dart';

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

  // Fetch deliveries based on status
  Future<List<SendOrder>> fetchDeliveries(String status) async {
    String? token = await _getAuthToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token', // Pass token as Bearer Authorization header
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Decode response and map to SendOrder model
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['success'] == true) {
        List<dynamic> deliveries = jsonResponse['sendOrders']; // Use sendOrders

        List<SendOrder> sendOrders = deliveries
            .map((delivery) => SendOrder.fromJson(delivery))
            .where((order) => order.status.toLowerCase() == status.toLowerCase()) // Filter by status
            .toList();

        return sendOrders; // Return the filtered list
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to load orders');
      }
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
