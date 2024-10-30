
import 'dart:convert';
import 'package:fama/Views/Profile/model/transactions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiService {
  final String baseUrl = 'https://fama-logistics.onrender.com/api/v1/wallet/viewAllTransactions';

  Future<String?> retrieveUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token']; // Return token for further use
    }
    return null;
  }

  Future<TransactionResponse?> fetchTransactions() async {
    try {
      String? token = await retrieveUserToken();
      if (token == null) {
        print('Error: User token not found');
        return null;
      }

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return TransactionResponse.fromJson(json.decode(response.body));
      } else {
        print('Error fetching transactions: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
