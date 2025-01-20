
class Request {
  
  String id;
  User user;
  String customerName;
  String productName; // Added to match API response
  int quantity;
  String productImage;
  String deliveryAddress;
  String additionalInfo;
  String requestId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Request({
    required this.id,
    required this.user,
    required this.customerName,
    required this.productName, // Added to constructor
    required this.quantity,
    required this.productImage,
    required this.deliveryAddress,
    required this.additionalInfo,
    required this.requestId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['_id'],
      user: User.fromJson(json['userId']),
      customerName: json['customerName'],
      productName: json['productName'], // Parse productName
      quantity: json['quantity'],
      productImage: json['productImage'],
      deliveryAddress: json['deliveryAddress'],
      additionalInfo: json['additionalInfo'],
      requestId: json['requestId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class User {
  String id;
  String fullName;
  String address; // Optional: Include if required
  String country;
  String phoneNumber; // Changed to String to handle large numbers

  User({
    required this.id,
    required this.fullName,
    this.address = "", // Set default if not always provided
    required this.country,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      country: json['country'],
      phoneNumber: json['phoneNumber'].toString(), // Ensure String conversion
    );
  }
}
