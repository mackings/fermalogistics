import 'dart:convert';
import 'package:getnamibia/Views/Tracking/Model/scanmodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductApiService {
  final String baseUrl =
      'https://fama-logistics-ljza.onrender.com/api/v1/qrcode';

  Future<String?> _retrieveUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      print('User Token: ${userData['token']}');
      return userData['token'];
    }
    return null;
  }

  Future<Product?> fetchProductById(String productId) async {
    final token = await _retrieveUserToken();
    if (token == null) {
      print("User token not found.");
      return null;
    }

    final url = Uri.parse('$baseUrl/getProductByQrcode/$productId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("Full Response: $json");

      final scanResult = ScanResult.fromJson(json);
      return scanResult.product;
    } else {
      print("Error: ${response.statusCode} ${response.body}");
      return null;
    }
  }
  
}