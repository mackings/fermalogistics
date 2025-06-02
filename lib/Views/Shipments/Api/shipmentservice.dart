import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShipmentService {
  final String apiUrl = 'https://fama-logistics-ljza.onrender.com/api/v1/dropShipperTracking/viewAllShipments';

  // Fetch User Token from SharedPreferences
  Future<String?> _retrieveUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token'];
    }
    return null;
  }

  // Fetch Shipments from API
  Future<List<dynamic>> fetchShipments() async {
    String? userToken = await _retrieveUserToken();
    if (userToken == null) {
      throw Exception('User token not found.');
    }

    final url = Uri.parse(apiUrl);
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $userToken',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['shipments'];
    } else {
      throw Exception('Failed to load shipments');
    }
  }
}
