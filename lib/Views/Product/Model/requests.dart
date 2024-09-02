class Request {
  String id;
  User user;
  String customerName;
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
  String address;
  String country;
  int phoneNumber;

  User({
    required this.id,
    required this.fullName,
    required this.address,
    required this.country,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      address: json['address'],
      country: json['country'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
