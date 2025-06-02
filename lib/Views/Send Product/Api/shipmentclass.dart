import 'dart:convert';
import 'package:http/http.dart' as http;

class SendOfferService {
  static Future<Map<String, dynamic>?> calculateShipmentCost(
      Map<String, Object> data, String? token) async {
    final url =
        'https://fama-logistics-ljza.onrender.com/api/v1/dropshipperShipment/calculateShipmentCost';

    try {
      print(data);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Add the Bearer token here
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print("Failed to calculate shipment cost: ${response.body}");
        return null;
      }
    } catch (error) {
      print("Error in API request: $error");
      return null;
    }
  }
}
