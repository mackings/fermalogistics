import 'dart:convert';
import 'package:http/http.dart' as http;


class ForgotPasswordService {
  static const String _baseUrl = "https://fama-logistics.onrender.com/api/v1/user";

  // Send Reset Link
  Future<bool> sendResetLink(String email) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/forgotPassword"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Success
      } else {
        print("Error: ${response.body}");
        return false; // Failure
      }
    } catch (e) {
      print("Network Error: $e");
      return false; // Error occurred
    }
  }

  // Reset Password
  Future<bool> resetPassword(String token, String newPassword) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/resetPassword"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "token": token,
          "password": newPassword,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Success
      } else {
        print("Error: ${response.body}");
        return false; // Failure
      }
    } catch (e) {
      print("Network Error: $e");
      return false; // Error occurred
    }
  }
}
