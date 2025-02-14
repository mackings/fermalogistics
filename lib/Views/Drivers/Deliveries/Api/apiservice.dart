import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/ordermodel.dart';




class DeliveryService {
  final String upcomingOrdersUrl =
      'https://fama-logistics.onrender.com/api/v1/delivery/getAllSendOrders';
  final String completedOrdersUrl =
      'https://fama-logistics.onrender.com/api/v1/delivery/getAllCompletedOrders';
  final String cancelledOrdersUrl =
      'https://fama-logistics.onrender.com/api/v1/delivery/getAllCancelledOrders';

  // Retrieve auth token from SharedPreferences
  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token'];
    }
    return null;
  }

  // Fetch deliveries from the given URL
  Future<List<SendOrder>> _fetchOrders(String url) async {
    String? token = await _getAuthToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        List<dynamic> deliveries = jsonResponse['sendOrders'];
        if (deliveries.isEmpty) {
          return []; // Return empty list if no orders are found
        }
        return deliveries.map((delivery) => SendOrder.fromJson(delivery)).toList();
      } else {
        throw Exception(jsonResponse['message'] ?? 'Failed to load orders');
      }
    } else if (response.statusCode == 404) {
      return []; // Return empty list if the endpoint is not found (404)
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  // Fetch Upcoming Orders
  Future<List<SendOrder>> fetchUpcomingOrders() async {
    return await _fetchOrders(upcomingOrdersUrl);
  }

  // Fetch Completed Orders
  Future<List<SendOrder>> fetchCompletedOrders() async {
    return await _fetchOrders(completedOrdersUrl);
  }

  // Fetch Cancelled Orders
  Future<List<SendOrder>> fetchCancelledOrders() async {
    return await _fetchOrders(cancelledOrdersUrl);
  }
}


