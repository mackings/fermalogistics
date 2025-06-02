import 'package:getnamibia/Views/Auth/signin.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SwitchProfile extends StatefulWidget {
  const SwitchProfile({super.key});

  @override
  State<SwitchProfile> createState() => _SwitchProfileState();
}

class _SwitchProfileState extends State<SwitchProfile> {
  bool _isLoading = false;

  Future<String?> retrieveUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token']; // Return token for further use
    }
    return null;
  }

  Future<void> switchToDriver() async {
    setState(() {
      _isLoading = true;
    });

    String url =
        "https://fama-logistics-ljza.onrender.com/api/v1/user/userToggleRoles";
    String? token = await retrieveUserToken();

    if (token == null) {
      showSnackBar("Authentication failed. Please log in again.",
          isError: true);
      return;
    }

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      // Print API response for debugging
      print("🔹 Response Status: ${response.statusCode}");
      print("🔹 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        showSnackBar("Switched to driver successfully!", isError: false);

        // Navigate to login after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Signin()));
        });
      } else {
        showSnackBar("Failed to switch profile. Try again.", isError: true);
      }
    } catch (e) {
      showSnackBar("An error occurred. Please try again.", isError: true);
      print("❌ Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showSnackBar(String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Become a Driver")
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.red,)
              : CustomButton(text: "Switch Account", onPressed: switchToDriver,)
        ),
      ),
    );
  }
}
