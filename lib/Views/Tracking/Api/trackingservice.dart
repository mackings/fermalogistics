import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class TrackingApiService {
  final String baseUrl = 'https://fama-logistics-ljza.onrender.com/api/v1/dropShipperTracking';

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
  final String? status; // Nullable
  final String? pickupAddress; // Nullable
  final String? receiverAddress; // Nullable
  final String? receiverName; // Nullable
  final String? receiverPhoneNumber; // Nullable
  final String senderName;
  final double weightOfPackage;
  final int? numberOfPackages; // Nullable
  final String? packageCategory; // Nullable
  final String? shipmentMethod; // Nullable
  final double? amount; // Nullable
  final bool? isPaid; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;

  Shipment({
    required this.trackingNumber,
    this.status,
    this.pickupAddress,
    this.receiverAddress,
    this.receiverName,
    this.receiverPhoneNumber,
    required this.senderName,
    required this.weightOfPackage,
    this.numberOfPackages,
    this.packageCategory,
    this.shipmentMethod,
    this.amount,
    this.isPaid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      trackingNumber: json['trackingNumber'] ?? '',
      status: json['status'],
      pickupAddress: json['pickupAddress'],
      receiverAddress: json['receiverAddress'], // Corrected API spelling
      receiverName: json['receiverName'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      senderName: json['senderName'] ?? '',
      weightOfPackage: (json['weightOfPackage'] ?? 0).toDouble(),
      numberOfPackages: json['numberOfPackages'],
      packageCategory: json['packageCategory'],
      shipmentMethod: json['shipmentMethod'],
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      isPaid: json['isPaid'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
