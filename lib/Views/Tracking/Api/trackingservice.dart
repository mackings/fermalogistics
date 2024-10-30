import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrackingApiService {
  final String baseUrl = 'https://fama-logistics.onrender.com/api/v1/dropShipperTracking';

  Future<String?> _retrieveUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token'];
    }
    return null;
  }

  Future<Shipment?> fetchShipment(String trackingNumber) async {
    final token = await _retrieveUserToken();
    if (token == null) {
      // Handle token retrieval error or return null
      print("User token not found.");
      return null;
    }

    final url = Uri.parse('$baseUrl/trackingShipment/$trackingNumber');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      return Shipment.fromJson(json['shipment']);
    } else {
      print("Error: ${response.statusCode} ${response.body}");
      return null;
    }
  }
}

class Shipment {
  final String trackingNumber;
  final String status;
  final String pickupAddress;
  final String receiverAddress;
  final String senderName;
  final double weightOfPackage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Shipment({
    required this.trackingNumber,
    required this.status,
    required this.pickupAddress,
    required this.receiverAddress,
    required this.senderName,
    required this.weightOfPackage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      trackingNumber: json['trackingNumber'],
      status: json['status'],
      pickupAddress: json['pickupAddress'],
      receiverAddress: json['recieverAddress'],
      senderName: json['senderName'],
      weightOfPackage: json['weightOfPackage'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
