import 'dart:convert';
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




class PickupService {

  final String pickupOrdersUrl =
      'https://fama-logistics.onrender.com/api/v1/delivery/getAllSendOrders';

  final String acceptOrderUrl =
      'https://fama-logistics.onrender.com/api/v1/delivery/acceptOrder/';

  final String confirmPickupUrl =
      'https://fama-logistics.onrender.com/api/v1/delivery/pickUpOrder/';

  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token'];
    }
    return null;
  }

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
          print('Errors ${jsonResponse['message']}');
          return null;
        }
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<bool> acceptOrder(String orderId) async {
    String? token = await _getAuthToken();
    if (token == null) {
      print('Error: Token not found');
      return false;
    }

    try {
      final response = await http.put(
        Uri.parse('$acceptOrderUrl$orderId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"status": "processing"}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          print('Order Accepted Successfully');
          return true;
        } else {
          print('Error: ${jsonResponse['message']}');
          return false;
        }
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }



  Future<Map<String, dynamic>> confirmPickup(String orderId) async {
    String? token = await _getAuthToken();
    if (token == null) {
      return {'success': false, 'message': 'Authentication token not found'};
    }

    try {
      final response = await http.put(
        Uri.parse('$confirmPickupUrl$orderId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"status": "in-transit"}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Pickup confirmed successfully'};
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
    String errorMessage = errorData['message'] ?? 'Unknown error occurred';
      
        return {
         'success': false,
      'message': ' $errorMessage'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Exception: $e'};
    }
  }

  Future<Map<String, dynamic>> markDeliveryArrived(String orderId) async {
    String? token = await _getAuthToken();
    if (token == null) {
      return {'success': false, 'message': 'Authentication token not found'};
    }

    try {
      final response = await http.put(
        Uri.parse(
            'https://fama-logistics.onrender.com/api/v1/delivery/deliveryArrived/$orderId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"status": "arrived"}),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Driver has arrived at the destination'
        };
      } else {
        return {
          'success': false,
          'message': 'Error ${response.statusCode}: ${response.body}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Exception: $e'};
    }
  }



  Future<Map<String, dynamic>> markDeliveryCompleted(String orderId) async {
    String? token = await _getAuthToken();
    if (token == null) {
      return {'success': false, 'message': 'Authentication token not found'};
    }

    try {
      final response = await http.put(
        Uri.parse(
            'https://fama-logistics.onrender.com/api/v1/delivery/deliveryCompleted/$orderId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        // body: jsonEncode({"status": "completed"}),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Delivery has been completed successfully'
        };
      } else {
        print(response.body);
        return {
          'success': false,
          'message': 'Error ${response.statusCode}: ${response.body}'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Exception: $e'};
    }
  }

  
}
