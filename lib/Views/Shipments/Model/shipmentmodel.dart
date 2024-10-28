class Shipment {
  final String id;
  final String userId;
  final String senderName;
  final String phoneNumber;
  final String pickupAddress;
  final String emailAddress;
  final String receiverName;
  final String receiverPhoneNumber;
  final String receiverAddress;
  final String receiverEmailAddress;
  final String itemName;
  final double weightOfPackage;
  final String packageCategory;
  final int numberOfPackages;
  final double length;
  final double width;
  final double height;
  final String shipmentMethod;
  final double amount;
  final bool isPaid;
  final double tax;
  final String status;
  final String trackingNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  Shipment({
    required this.id,
    required this.userId,
    required this.senderName,
    required this.phoneNumber,
    required this.pickupAddress,
    required this.emailAddress,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.receiverAddress,
    required this.receiverEmailAddress,
    required this.itemName,
    required this.weightOfPackage,
    required this.packageCategory,
    required this.numberOfPackages,
    required this.length,
    required this.width,
    required this.height,
    required this.shipmentMethod,
    required this.amount,
    required this.isPaid,
    required this.tax,
    required this.status,
    required this.trackingNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create Shipment instance from JSON
  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      senderName: json['senderName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      pickupAddress: json['pickupAddress'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      receiverName: json['recieverName'] ?? '',
      receiverPhoneNumber: json['recieverPhoneNumber'] ?? '',
      receiverAddress: json['recieverAddress'] ?? '',
      receiverEmailAddress: json['recieverEmailAddress'] ?? '',
      itemName: json['itemName'] ?? '',
      weightOfPackage: (json['weightOfPackage'] as num?)?.toDouble() ?? 0.0,
      packageCategory: json['packageCategory'] ?? '',
      numberOfPackages: json['numberOfPackages'] ?? 0,
      length: (json['length'] as num?)?.toDouble() ?? 0.0,
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      shipmentMethod: json['shipmentMethod'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      isPaid: json['isPaid'] ?? false,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      trackingNumber: json['trackingNumber'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Convert List of JSON objects to List of Shipment objects
  static List<Shipment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Shipment.fromJson(json)).toList();
  }
}
