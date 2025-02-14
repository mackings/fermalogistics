import 'dart:convert';
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class PickupService {
  final String pickupOrdersUrl =
      'https://fama-logistics.onrender.com/api/v1/delivery/getAllSendOrders';

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

  // Fetch Pickup Orders
  Future<PickupModel?> fetchPickupOrders() async {
    String? token = await _getAuthToken();
    if (token == null) {
      print('Error: Token not found');
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse(pickupOrdersUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          return PickupModel.fromMap(jsonResponse);
        } else {
          print('Error: ${jsonResponse['message']}');
          return null;
        }
      } else if (response.statusCode == 404) {
        print('Error: No orders found (404)');
        return null;
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
