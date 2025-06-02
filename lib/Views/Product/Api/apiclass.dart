import 'package:http/http.dart' as http;
import 'dart:convert';

class QuoteApiService {
  final String baseUrl =
      'https://fama-logistics-ljza.onrender.com/api/v1/quote';

  Future<Map<String, dynamic>> createQuote({
    required String fromLocation,
    required String destination,
    required double weight,
    required int quantity,
    required double height,
    required double width,
    required double length,
    required String rates,
    required String userToken,
  }) async {
    Map<String, dynamic> requestBody = {
      "fromLocation": fromLocation,
      "destination": destination,
      "weight": weight,
      "quantity": quantity,
      "height": height,
      "width": width,
      "length": length,
      "rates": rates.isNotEmpty ? rates[0].toUpperCase() + rates.substring(1) : '',
    };

    final response = await http.post(
      Uri.parse('$baseUrl/createQuote'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $userToken', // Use token if the API requires it
      },
      body: jsonEncode(requestBody),
    );

    print(requestBody);

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create quote: ${response.reasonPhrase}');
    }
  }
}
